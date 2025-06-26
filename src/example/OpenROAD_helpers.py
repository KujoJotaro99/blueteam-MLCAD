import os
import pdn, odb, utl
from openroad import Tech, Design, Timing
import openroad as ord
from collections import defaultdict
from pathlib import Path

def load_design(design_name, verilog = False):
  tech = Tech()
  libDir = Path("../../platform/ASAP7/lib/")
  lefDir = Path("../../platform/ASAP7/lef/")
  designDir = Path("../../designs/%s/EDA_files/"%design_name)

  # Read technology files
  libFiles = libDir.glob('*.lib')
  lefFiles = lefDir.glob('*.lef')
  for libFile in libFiles:
    tech.readLiberty(libFile.as_posix())
  techLefFiles = lefDir.glob("*tech*.lef")
  for techLefFile in techLefFiles:
    tech.readLef(techLefFile.as_posix())
  for lefFile in lefFiles:
    tech.readLef(lefFile.as_posix())
  design = Design(tech)

  # Read design files
  if verilog:
    verilogFile = "%s/%s.v"%(designDir.as_posix(), design_name)
    design.readVerilog(verilogFile)
    design.link(design_name)
    
  defFile = "%s/%s_fp.def.gz"%(designDir.as_posix(), design_name)
  design.evalTclString("read_def -floorplan_initialize "+defFile)

    

  # Read the SDC file, SPEF file, and set the clocks
  sdcFile = "%s/%s.sdc"%(designDir.as_posix(), design_name)
  design.evalTclString("read_sdc %s"%sdcFile)
  design.evalTclString("source ../../platform/ASAP7/setRC.tcl")
  
  # Global connect
  VDDNet = design.getBlock().findNet("VDD")
  if VDDNet is None:
    VDDNet = odb.dbNet_create(design.getBlock(), "VDD")
  VDDNet.setSpecial()
  VDDNet.setSigType("POWER")
  VSSNet = design.getBlock().findNet("VSS")
  if VSSNet is None:
    VSSNet = odb.dbNet_create(design.getBlock(), "VSS")
  VSSNet.setSpecial()
  VSSNet.setSigType("GROUND")
  design.getBlock().addGlobalConnect(None, ".*", "VDD", VDDNet, True)
  design.getBlock().addGlobalConnect(None, ".*", "VSS", VSSNet, True)
  design.getBlock().globalConnect()

  return tech, design

def get_connection(net):
  block = ord.get_db_block()
  net = block.findNet(net)
  sink_pins = []
  for p in net.getITerms():
    if p.isOutputSignal():
      d_pin = p
    else:
      sink_pins.append(p)
  print("Driver: ",d_pin.getName())
  for p in sink_pins:
    print("Sink: ",p.getName())
  print('\n')
  
def get_inst_connection(inst):
  block = ord.get_db_block()
  inst = block.findInst(inst)
  in_pins = []
  out_pins = []
  for pin in inst.getITerms():
    if pin.isOutputSignal():
      out_pins.append(pin)
    elif pin.isInputSignal():
      in_pins.append(pin)
  for pin in in_pins:
    driver = [x for x in pin.getNet().getITerms() if x.isOutputSignal()][0]
    print("Input pin ",pin.getName(),"is connected to ",driver.getName())
  for pin in out_pins:
    print("Connections to output pin ",pin.getName())
    for p in pin.getNet().getITerms():
      if p.isInputSignal():
        print(p.getName())
  print('\n')


def connect_pg(inst, power_net, gnd_net):
  for pin in inst.getITerms():
    sig_type = pin.getSigType()
    if sig_type == 'POWER' and power_net:
      pin.connect(power_net)
    elif sig_type == 'GROUND' and gnd_net:
      pin.connect(gnd_net)

# Function to insert a buffer cell by breaking a given net
def insert_buffer(net, buf_cell):
  db = ord.get_db()
  block = ord.get_db_block()
  
  source_net = block.findNet(net)
  for pin in source_net.getITerms():
    if pin.isOutputSignal():
      source_pin = pin
  source_inst = source_pin.getInst()
  for pin in source_inst.getITerms():
    if pin.getSigType() == 'POWER':
      power_net = pin.getNet()
    elif pin.getSigType() == 'GROUND':
      gnd_net = pin.getNet()
  # Find the master instance named 'BUF_X2'
  mast = db.findMaster(buf_cell)
  # Create a new instance named 'new_inst_1' using the 'BUF_X2' master
  new_inst = odb.dbInst_create(block,mast,'new_buffer_1')
  # Create a new net
  new_net = odb.dbNet_create(block,'new_buffer_net_1')
  # Disconnect the source pin
  source_pin.disconnect()
  # Connect the source pin to the new net
  source_pin.connect(new_net)
  # Connect the pins of the new instance
  for pin in new_inst.getITerms():
    if pin.isInputSignal():
      pin.connect(new_net)
    elif pin.isOutputSignal():
      pin.connect(source_net)
    elif pin.getSigType() == 'POWER':
      pin.connect(power_net)
    elif pin.getSigType() == 'GROUND':
      pin.connect(gnd_net)

def clone_gate(inst_name, new_inst_name):
  db = ord.get_db()
  block = ord.get_db_block()

  # Find the original instance
  orig_inst = block.findInst(inst_name)
  if not orig_inst:
    print(f"Error: Instance {inst_name} not found.")
    return

  # Find the master cell of the original instance
  mast = orig_inst.getMaster()

  # Create a new instance using the same master cell
  cloned_inst = odb.dbInst_create(block, mast, new_inst_name)

  power_net = None
  gnd_net = None

  # Identify input and output nets
  output_net = None
  for pin in orig_inst.getITerms():
    sig_type = pin.getSigType()

    if pin.isInputSignal():
      # Connect the cloned gate's input to the same net
      cloned_pin = cloned_inst.findITerm(pin.getMTerm().getName())
      cloned_pin.connect(pin.getNet())

    elif pin.isOutputSignal():
      output_net = pin.getNet()  # Get the output net of the original instance
      output_pin = pin

    elif sig_type == 'POWER':
      power_net = pin.getNet()
    elif sig_type == 'GROUND':
      gnd_net = pin.getNet()

  if output_net is None:
    print(f"Error: No output net found for {inst_name}.")
    return
  print("old net ",output_net.getName())
  # Create a new net for the cloned gate's output
  new_net = odb.dbNet_create(block, f"{new_inst_name}_out_net")
  print(new_net.getName())
    
  # Connect the cloned gate's output to the new net
  cloned_output_pin = cloned_inst.findITerm(output_pin.getMTerm().getName())
  cloned_output_pin.connect(new_net)

  # Get all sink pins of the original instance's output net
  sink_pins = [pin for pin in output_net.getITerms() if pin.isInputSignal() == 1]

  # Move half of the sink pins to the cloned instance's output net
  num_sinks_to_move = len(sink_pins) // 2
  for i, sink_pin in enumerate(sink_pins):
    if i < num_sinks_to_move:
      sink_pin.disconnect()
      sink_pin.connect(new_net)

  # Connect power and ground to the cloned gate
  for pin in cloned_inst.getITerms():
    sig_type = pin.getSigType()
    if sig_type == 'POWER' and power_net:
      pin.connect(power_net)
    elif sig_type == 'GROUND' and gnd_net:
      pin.connect(gnd_net)

  print(f"### Cloned gate {inst_name} as {new_inst_name} and moved {num_sinks_to_move} sink pins.")

