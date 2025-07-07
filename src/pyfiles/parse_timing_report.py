# see https://stackoverflow.com/q/62340329
import json
import argparse

parser = argparse.ArgumentParser(description="Parse timing report")
parser.add_argument("-d", "--design", type=str, default="ac97_top", help="Design name")
args = parser.parse_args()

with open(f"../../designs/{args.design}/Results/Run1/timing_report.rpt", "r") as f:
    paths = []
    slacks = []
    parse = False
    for line in f:
        if line.startswith("Startpoint"):
            if line.find("clocked by") == -1:
                raise RuntimeError("Asynchronous path, bug me because this script might not work properly")
            if next(f).find("clocked by") == -1:
                raise RuntimeError("Asynchronous path, bug me because this script might not work properly")
            parse = True
            paths.append([])
            # Skip lines
            for _ in range(3):
                next(f)
            # Find where "Description" is since this is where the pin names
            # start
            header = next(f)
            delay_i = header.index("Delay") + len("Delay")
            time_i = header.index("Time") + len("Time")
            description_i = header.index("Description")
            for _ in range(3):
                next(f)
        elif line.strip() == ("-" * 79):
            line = next(f)
            if line.find("slack") == -1:
                continue
            slacks.append(float(line[delay_i:time_i]))
        elif len(line) <= 1 and parse:
            # Get rid of the "data arrival time" entry
            paths[-1].pop()
            parse = False
        elif parse:
            paths[-1].append(line[description_i:].strip())

assert len(paths) == len(slacks), "Paths and slacks counts mismatch"
with open(f"../../designs/{args.design}/Results/Run1/timing_digest.json", "w") as f:
    json.dump([{"path": p, "slack": s} for p, s in zip(paths, slacks)], f)
