# see https://stackoverflow.com/q/62340329
import sys

with open("Results/timing_report.rpt", "r") as f:
    paths = []
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
            description_i = next(f).index("Description")
            for _ in range(3):
                next(f)
        elif len(line) <= 1:
            # Get rid of the "data arrival time" entry
            paths[-1].pop()
            parse = False
        elif parse:
            paths[-1].append(line[description_i:].strip())

if len(sys.argv) != 2:
    raise RuntimeError("Terminal spam L\n" * 2000)
with open(sys.argv[1], "w") as f:
    for path in paths:
        print(*path, sep=", ", file=f)
