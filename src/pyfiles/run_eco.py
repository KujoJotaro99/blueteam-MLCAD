import argparse
import json
import re
from pathlib import Path
from openroad import Tech, Design, Timing
from transformations import gate_sizing
from OpenROAD_helpers import insert_buffer

#create run directory
def next_run_dir(design_name: str):
    results = Path(f"../../designs/{design_name}/Results")
    runs = [p.name for p in results.iterdir() if p.is_dir() and re.match(r"Run\d+", p.name)]
    nums = [int(r[3:]) for r in runs]
    next_num = max(nums) + 1 if nums else 1
    run_dir = results / f"Run{next_num}"
    run_dir.mkdir(exist_ok=True)
    return run_dir

#main function
def apply_eco(design_name: str = "ac97_top", tech_name: str = "ASAP7"):
    #load tech files
    tech = Tech()
    for f in Path(f"../../platform/{tech_name}/lib").glob("*.lib"): tech.readLiberty(str(f))
    for f in Path(f"../../platform/{tech_name}/lef").glob("*tech*.lef"): tech.readLef(str(f))
    for f in Path(f"../../platform/{tech_name}/lef").glob("*.lef"): tech.readLef(str(f))

    #increment folder number
    results_dir = Path(f"../../designs/{design_name}/Results")
    run_dirs = [p for p in results_dir.iterdir() if p.is_dir() and re.match(r"Run\d+", p.name)]
    last_run = max(run_dirs, key=lambda p: int(p.name[3:]))
    design = Design(tech)
    #fixes issue with db block being none in transformations, tcl doesnt seem to populate the python's design object
    design.readDb(str(last_run / "6_final.odb")) 
    design.evalTclString(f"read_sdc {last_run}/6_final.sdc")
    design.evalTclString(f"source ../../platform/{tech_name}/setRC.tcl")
    design.evalTclString("estimate_parasitics -global_routing")

    #read timing digest (from Run1 always for now, need to implement for most recent run once we get nautilus up and running)
    digest = Path(f"../../designs/{design_name}/Results/Run1/timing_digest.json")
    with open(digest) as f:
        report = json.load(f)

    print(">>> Applying ECOs")
    timing = Timing(design)
    timing.makeEquivCells()
    blk = design.getBlock()

    #get slew entry
    for entry in report:
        slack = entry.get("slew", 0.0)
        if slack >= 0.0:
            continue

        #format name/count format to just name, reading fanout
        nets = [h.split("/")[0] for h in entry.get("path", []) if "/" in h]
        best_net, maxf = None, -1
        for n in set(nets):
            #get actual net object from net name string
            net = blk.findNet(n)
            if net:
                count = len(net.getITerms())
                if count > maxf:
                    best_net, maxf = n, count

        inst = insert_buffer(design, best_net)
        print(f"Inserted buffer {inst} on net {best_net} (fanout {maxf})")

        # #if the fanout is too large then just insert a buffer
        # if maxf > 8:
        #     inst = insert_buffer(design, best_net)
        #     print(f"Inserted buffer {inst} on net {best_net} (fanout {maxf})")
        # #otherwise default for now is just increasing drive 
        # else:
        #     last_hop = [h for h in entry.get("path", []) if "(" in h][-1]
        #     inst_name = last_hop.split()[0].split("/")[0]
        #     newm = gate_sizing(design, inst_name, direction=True)
        #     print(f"Upsized {inst_name} → {newm} (slack {slack})")

        design.evalTclString("update_timing -incremental")

    #write outputs to new runX directory
    run_dir = next_run_dir(design_name)
    base = f"{design_name}_post_route"
    i = 1
    while (run_dir / f"{base}_{i}.odb").exists():
        i += 1

    out_db  = run_dir / f"{base}_{i}.odb"
    out_def = run_dir / f"{base}_{i}.def"
    out_v   = run_dir / f"{base}_{i}.v"

    design.writeDb(str(out_db))
    design.evalTclString(f"write_def {out_def}")
    design.evalTclString(f"write_verilog {out_v}")

    print(f"ECO outputs in {run_dir}:\n  {out_db}\n  {out_def}\n  {out_v}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Apply ECOs based on timing digest")
    parser.add_argument("-d", "--design", default="ac97_top")
    parser.add_argument("-t", "--tech", default="ASAP7")
    args = parser.parse_args()
    apply_eco(args.design, args.tech)