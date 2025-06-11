import argparse
from pathlib import Path
from openroad import Tech, Design, Timing
import openroad as ord
import csv

#this is not the same as openroad helpers it uses the odb to load the design
def load_design_odb(odb_path, sdc_path, lib_dir, lef_dir):
    tech = Tech()
    for lib_file in Path(lib_dir).glob("*.lib"):
        tech.readLiberty(str(lib_file))
    for tech_lef_file in Path(lef_dir).glob("*tech*.lef"):
        tech.readLef(str(tech_lef_file))
    for lef_file in Path(lef_dir).glob("*.lef"):
        if "tech" not in str(lef_file):
            tech.readLef(str(lef_file))
    design = Design(tech)
    design.evalTclString(f"read_db {odb_path}")
    design.evalTclString(f"read_sdc {sdc_path}")
    return tech, design

# not fully confident if this is what every function does, tried to follow openroad helpers
# this is what i can understand from the scripts

# dbblock: the top-level design (block), entire chip or module, this is the main thing to load the design
            #   .getinsts()                                                                                     # returns a list of all cell instances (dbinst) placed in this block
#       dbinst: an occurrence of a cell or macro placed in the design
            #           .getname()                                                                              # returns the unique name of this instance
            #           .getmaster()                                                                            # returns the dbmaster object, which is the cell type (dff)
#               dbmaster: describes the cell type from the standard cell library
            #                   .getname()                                                                      # returns the name of the cell type (such as "nand_something" or "blabla")
            #                   .getmterms()                                                                    # returns all pin definitions for this cell type such as output Y and inputs A and B
#                       dbmterm: defines a pin on the library cell, so generic
            #                           .getname()                                                              # the pin's name 
            #                           .getsigtype()                                                           # returns signal type ("POWER", "GROUND")
            #           .getiterms()                                                                            # returns all pins for this instance, which are the actual pins in the design
#               dbiterm: a specific pin/terminal of this placed instance, so not generic
            #                   .getname()                                                                      # pin name on this instance
            #                   .getinst()                                                                      # the parent dbinst (the instance this pin belongs to)
            #                   .getnet()                                                                       # the net this pin is connected
            #                   .isinputsignal()                                                                # returns true if this pin is an input
            #                   .isoutputsignal()                                                               # returns true if this pin is an output
            #                   .getmterm()                                                                     # returns the dbmterm for this pin (pin's definition on the library cell)
            #           .getbbox()                                                                              # returns instance's bounding box
#
            #   .getnets()                                                                                      # returns all signal nets in the block, which are connections between pins
#       dbnet: represents a net or wire
            #           .getname()                                                                              # net's name
            #           .getiterms()                                                                            # returns all instances of pins attached to this net
            #           .getsigtype()                                                                           # returns net type ("POWER", "GROUND")
#
#
#
#
# what openroad helpers uses(not 100% sure):
#   - get cell coordinates:           inst.getbbox().xmin(), inst.getbbox().ymin()
#   - get instance type:              inst.getmaster().getname()
#   - determine pin direction:        pin.isinputsignal(), pin.isoutputsignal()
#   - find the net for a pin:         pin.getnet().getname()

def extract_design_data(design):
    block = ord.get_db_block()
    timing = Timing(design)
    cells, pins, nets = [], [], []

    #get start and endpoints, im pretty sure this doesnt work since openroad helpers used a tcl macro and also the outputted csv file is always 0 for all pins
    try:
        startpoints = set(sp.getName() for sp in timing.startpoints())
        endpoints = set(ep.getName() for ep in timing.endpoints())
    except Exception:
        startpoints = set()
        endpoints = set()

    #gets all cell/macro instances in the design
    for inst in block.getInsts():
        #othewise csv is too big
        if inst.getMaster().isFiller():
            continue
        #get size/position
        bbox = inst.getBBox()
        #cell 
        cells.append({
            "cell_name": inst.getName(),
            #gets generic cell type and the name of that cell library
            "cell_type": inst.getMaster().getName(),
            #find size
            "x": bbox.xMin(),
            "y": bbox.yMin(),
        })
        #traverses pin instances for EACH cell.macro in the design
        for pin in inst.getITerms():
            #get net
            net = pin.getNet()
            #needed to use openroad API for every single pin manually
            try:
                slack_r = timing.getPinSlack(pin, timing.Rise, timing.Max)
                slack_f = timing.getPinSlack(pin, timing.Fall, timing.Max)
                #choose the smaller slack between rise and fall
                pin_slack = min(slack_r, slack_f)
            except Exception:
                pin_slack = None
            #get slew
            try:
                pin_slew = timing.getPinSlew(pin)
            except Exception:
                pin_slew = None
            try:
            #get cap
                pin_cap = timing.getPortCap(pin, timing.getCorners()[0], timing.Max) if pin.isInputSignal() else -1
            except Exception:
                pin_cap = None
            
            try:
                mterm = [mt for mt in pin.getInst().getMaster().getMTerms() if mt.getName() == pin.getMTerm().getName()][0]
                max_cap = timing.getMaxCapLimit(mterm)
                max_slew = timing.getMaxSlewLimit(mterm)
            except Exception:
                max_cap = None
                max_slew = None
            try:
                arr_r = timing.getPinArrival(pin, timing.Rise)
                arr_f = timing.getPinArrival(pin, timing.Fall)
            except Exception:
                arr_r = arr_f = None
            #add to pin object
            pin_full = f"{inst.getName()}/{pin.getName()}"
            is_endpoint = int(pin_full in endpoints or inst.getName() in endpoints)
            is_startpoint = int(pin_full in startpoints or inst.getName() in startpoints)
            pins.append({
                "pin_name": pin.getName(),
                "cell_name": inst.getName(),
                "net_name": net.getName() if net else None,
                "is_input": pin.isInputSignal(),
                "is_output": pin.isOutputSignal(),
                "slack": pin_slack,
                "slew": pin_slew,
                "cap": pin_cap,
                "max_cap": max_cap,
                "max_slew": max_slew,
                "arrival_rise": arr_r,
                "arrival_fall": arr_f,
                #"is_endpoint": is_endpoint, #removed since im pretty sure the method of collectin gthis is wrong
                #"is_startpoint": is_startpoint,
            })
    #traverse the nets
    for net in block.getNets():
        #get all pins that are inputs atached to this net
        sinks = [p.getName() for p in net.getITerms() if p.isInputSignal()]
        #get all pins that are outputs atached to this net
        driver = [p.getName() for p in net.getITerms() if p.isOutputSignal()]
        nets.append({
            "net_name": net.getName(),
            "driver_pin": driver[0] if driver else None,
            "sink_pins": sinks,
            "fanout": len(sinks)
        })
    return cells, pins, nets

#dump everything into csv
def write_csv(data, fname):
    if not data:
        print(f"Warning: No data for {fname}")
        return
    with open(fname, "w", newline='') as f:
        writer = csv.DictWriter(f, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="gets pin, cell, and net features using openroad API")
    parser.add_argument("-d", "--design", type=str, default="ac97_top", help="Design name")
    parser.add_argument("-p", "--platform", type=str, default="ASAP7", help="Platform name")
    args = parser.parse_args()

    ODB_PATH = f"../../designs/{args.design}/Results/6_final.odb"
    SDC_PATH = f"../../designs/{args.design}/Results/6_final.sdc"
    LIB_PATH = f"../../platform/{args.platform}/lib"
    LEF_PATH = f"../../platform/{args.platform}/lef"

    tech, design = load_design_odb(ODB_PATH, SDC_PATH, LIB_PATH, LEF_PATH)
    cells, pins, nets = extract_design_data(design)

    write_csv(cells, f"../../designs/{args.design}/IR_Tables/cells.csv")
    write_csv(pins, f"../../designs/{args.design}/IR_Tables/pins.csv")
    write_csv(nets, f"../../designs/{args.design}/IR_Tables/nets.csv")
    print("CSV files written: cells.csv, pins.csv, nets.csv")
