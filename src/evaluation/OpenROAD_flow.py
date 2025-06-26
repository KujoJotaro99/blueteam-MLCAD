from openroad import Tech, Design, Timing
import pdn, odb, utl
import openroad as ord
from pathlib import Path
import os, argparse, shutil, re

def config_gnc(design):
    for net in design.getBlock().getNets():
        if net.getSigType() == "POWER" or net.getSigType() == "GROUND":
            net.setSpecial()

    VDD_net = design.getBlock().findNet("VDD")
    VSS_net = design.getBlock().findNet("VSS")

    # Create VDD/VSS nets if they don't exist
    if VDD_net == None:
        VDD_net = odb.dbNet_create(design.getBlock(), "VDD")
        VDD_net.setSpecial()
        VDD_net.setSigType("POWER")
        odb.dbBTerm_create(VDD_net , 'VDD')

    if VSS_net == None:
        VSS_net = odb.dbNet_create(design.getBlock(), "VSS")
        VSS_net.setSpecial()
        VSS_net.setSigType("GROUND")
        odb.dbBTerm_create(VSS_net , 'VSS')
    
    # Connect power pins to global nets
    design.getBlock().addGlobalConnect(region = None,
        instPattern = ".*", 
        pinPattern = "^VDD$",
        net = VDD_net, 
        do_connect = True)
    design.getBlock().addGlobalConnect(region = None,
        instPattern = ".*",
        pinPattern = "^VDDPE$",
        net = VDD_net,
        do_connect = True)
    design.getBlock().addGlobalConnect(region = None,
        instPattern = ".*",
        pinPattern = "^VDDCE$",
        net = VDD_net,
        do_connect = True)
    design.getBlock().addGlobalConnect(region = None,
        instPattern = ".*",
        pinPattern = "^VSS$",
        net = VSS_net, 
        do_connect = True)
    design.getBlock().addGlobalConnect(region = None,
        instPattern = ".*",
        pinPattern = "^VSSE$",
        net = VSS_net,
        do_connect = True)
    design.getBlock().globalConnect()

def run_flow(design_name):
    # This is the flow to run placement and global routing using OpenROAD.
    # The same flow will be used during evaluation phase.
    
    # Initialize OpenROAD objects and read technology files
    tech = Tech()
    # Set paths to library and design files
    libDir = Path("../../platform/ASAP7/lib/")
    lefDir = Path("../../platform/ASAP7/lef/")
    designDir = Path("../../designs/%s/EDA_files/"%design_name)

    # Read all liberty (.lib) and LEF files from the library directories
    libFiles = libDir.glob("*.lib")
    techLefFiles = lefDir.glob("*tech*.lef")
    lefFiles = lefDir.glob('*.lef')
    
    # Load liberty timing libraries
    for libFile in libFiles:
        tech.readLiberty(libFile.as_posix())
    
    # Load technology and cell LEF files  
    for techLefFile in techLefFiles:
        tech.readLef(techLefFile.as_posix())
    
    for lefFile in lefFiles:
        tech.readLef(lefFile.as_posix())
    
    design = Design(tech)

    # Read netlist
    verilogFile = "%s/%s.v"%(designDir.as_posix(), design_name)
    design.readVerilog(verilogFile)
    design.link(design_name)
    
    # Config Global Net Connect
    config_gnc(design)

    # Read floorplan def file
    defFile = "%s/%s_fp.def.gz"%(designDir.as_posix(), design_name)
    design.evalTclString("read_def -floorplan_initialize "+defFile)
    #design.readDef(defFile)
   
    # Read the SDC file
    sdcFile = "%s/%s.sdc"%(designDir.as_posix(), design_name)
    design.evalTclString("read_sdc %s"%sdcFile)
    design.evalTclString("source ../../platform/ASAP7/setRC.tcl")
    
    # Configure and run global placement
    print("###run global placement###")

    design.evalTclString("global_placement -routability_driven -init_density_penalty 0.05 -initial_place_max_iter 10")
    
    # Run initial detailed placement
    site = design.getBlock().getRows()[0].getSite()
    max_disp_x = int((design.getBlock().getBBox().xMax() - design.getBlock().getBBox().xMin()) / site.getWidth())
    max_disp_y = int((design.getBlock().getBBox().yMax() - design.getBlock().getBBox().yMin()) / site.getHeight())
    print("###run legalization###")
    design.getOpendp().detailedPlacement(max_disp_x, max_disp_y, "")
    
    # Run Global Routing and Estimate Global Routing RC
    signal_low_layer = design.getTech().getDB().getTech().findLayer("M1").getRoutingLevel()
    signal_high_layer = design.getTech().getDB().getTech().findLayer("M8").getRoutingLevel()
    clk_low_layer = design.getTech().getDB().getTech().findLayer("M1").getRoutingLevel()
    clk_high_layer = design.getTech().getDB().getTech().findLayer("M8").getRoutingLevel()
    grt = design.getGlobalRouter()
    grt.clear()
    grt.setAllowCongestion(True)
    grt.setMinRoutingLayer(signal_low_layer)
    grt.setMaxRoutingLayer(signal_high_layer)
    grt.setMinLayerForClock(clk_low_layer)
    grt.setMaxLayerForClock(clk_high_layer)
    grt.setAdjustment(0.5)
    grt.setVerbose(True)
    print("###run global routing###")
    grt.globalRoute(False)

    #design.evalTclString("set_routing_layers -signal M1-M8 -clock M1-M8")
    #design.evalTclString("set_global_routing_layer_adjustment * 0.5")
    #design.evalTclString("global_route -allow_congestion")
    design.evalTclString("estimate_parasitics -global_routing")

    fileDir = "./"    
    metrics = run_evaluation(design, fileDir+"gr_results.csv")
    compute_score(*metrics)

    # Write final DEF file
    #design.writeDef("%s/post_global_route.def"%outDir)
    
    # Write final Verilog file
    #design.evalTclString("write_verilog %s/post_global_route.v"%outDir)
    
    # Write final odb file
    #design.writeDb("%s/post_global_route.odb"%outDir)

def run_evaluation(design, fname):
    # Get all timing metrices
    timing = Timing(design)
    corner = timing.getCorners()[0]
    
    design.evalTclString("report_tns > evaluation_temp.txt")
    with open ("evaluation_temp.txt", "r") as file:
      for line in file:
        tns = float(line.split()[-1]) / 1000
    os.remove("evaluation_temp.txt")
    
    design.evalTclString("report_wns > evaluation_temp.txt")
    with open ("evaluation_temp.txt", "r") as file:
      for line in file:
        wns = float(line.split()[-1]) / 1000
    os.remove("evaluation_temp.txt")

    slew_viol_count = 0
    cap_viol_count = 0
    slew = 0
    cap = 0
    leakage = 0
    
    for pin_ in design.getBlock().getITerms():
      if pin_.getNet() != None:
        if pin_.getNet().getSigType() != 'POWER' and pin_.getNet().getSigType() != 'GROUND' and pin_.getNet().getSigType() != 'CLOCK' and not re.match(".*/SETN$", pin_.getName()) and not re.match(".*/RESETN$", pin_.getName()) :
          library_cell_pin = [MTerm for MTerm in pin_.getInst().getMaster().getMTerms() if (pin_.getInst().getName() + "/" + MTerm.getName()) == pin_.getName()][0]
          if timing.getMaxSlewLimit(library_cell_pin) < timing.getPinSlew(pin_):
            diff = abs(timing.getMaxSlewLimit(library_cell_pin) - timing.getPinSlew(pin_)) * 1e9
            slew += diff
            slew_viol_count += 1
          if pin_.isOutputSignal():
            if timing.getMaxCapLimit(library_cell_pin) < timing.getNetCap(pin_.getNet(), corner, timing.Max):
              diff = abs(timing.getMaxCapLimit(library_cell_pin) - timing.getNetCap(pin_.getNet(), corner, timing.Max)) * 1e15
              cap += diff
              cap_viol_count += 1
    db = ord.get_db()
    swapped_master = {}

    insts = design.getBlock().getInsts()
    for inst in insts:
      leakage += timing.staticPower(inst, corner)
      if not inst.getMaster().isBlock() and design.isSequential(inst.getMaster()):
        swapped_master[inst.getName()] = inst.getMaster().getName()
    leakage *= 1e6
    leakageBeforeSwap = 0
    
    design_name = design.getBlock().getName()
    total_insts = len(insts)

    grt = design.getGlobalRouter()
    overflow = grt.getOverflow()

    out_str = design_name+","+str(total_insts)+","+str(wns)+","+str(tns)+","+str(slew)+","+str(slew_viol_count)+","+str(cap)+","+str(cap_viol_count)+","+str(leakage)+","+str(overflow)+'\n'
    with open(fname,'a') as fp:
        fp.write(out_str)

    return leakage, tns, slew, cap, overflow


def compute_score(leakage, tns, slew, cap, overflow):

    # Penalty values to be updated after alpha submission
    tnsPenalty = 1
    slewPenalty = 1
    capPenalty = 1
    overfPenalty = 1

    # Adjust penalties
    tnsPenalty = 0 if tns >= 0.0 else tnsPenalty
    slewPenalty = 0 if slew == 0.0 else slewPenalty
    capPenalty = 0 if cap == 0.0 else capPenalty 
    overfPenalty = 0 if overflow == 0.0 else overfPenalty 

    # Compute score
    score = leakage + tnsPenalty * abs(tns) + slewPenalty * abs(slew) + capPenalty * abs(cap) + overfPenalty * abs(overflow)
    print("===================================================")
    print("TNS: %f ns"%(tns))
    if slewPenalty != 0:
      print("Total slew violation difference: %f ns"%(slew))
    else:
      print("No slew violation")
    if capPenalty != 0:
      print("Total load capacitance violation difference: %f fF"%(cap))
    else:
      print("No load capacitance violation")
    if overfPenalty != 0:
      print("Total Overflow: %f "%(overflow))
    else:
      print("Overflow is zero")
      
    print("Leakage power difference: %f uW"%(leakage))
    print("Score: %f"%score)
    print("Require runtime in official score calculation")
    print("===================================================")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Options to run Floorplan to Global route in OpenROAD. Give design name.")
    parser.add_argument("-d", default="ac97_top", help="Give the design name")
    args = parser.parse_args()

    run_flow(args.d)
