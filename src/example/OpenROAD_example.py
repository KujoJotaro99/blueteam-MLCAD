import sys
from OpenROAD_helpers import *
import argparse

parser = argparse.ArgumentParser(description="Example script to perform timing optimization techniques using OpenROAD.")
parser.add_argument("-d", default="ac97_top", help="Give the design name")
parser.add_argument("-t", default="ASAP7", help="Give the technology node")
args = parser.parse_args() 

# -----------------------------------------------------
# This is an example script which shows how to perform 
# few timing optimization techniques
# using OpenROAD APIs.
#
# This script is curated for ac97_top design
# but this can be used for other designs as well
# by just changing the instance and net names
# used in this example.
#
# Go through the functions in OpenROAD_helpers.py
# to fully understand the implementation.
#
# -----------------------------------------------------

# Load the design using OpenROAD Python APIs
tech, design = load_design(args.d, True)
timing = Timing(design)
db = ord.get_db()
block = ord.get_db_block()

# -------------------
# --- Gate sizing ---
# -------------------
print("\n# --- Gate sizing ---")
timing.makeEquivCells()

# First pick an instance
inst = block.findInst("g213146")

# Then get the library cell information
inst_master = inst.getMaster()
print("-----------Reference library cell-----------")
print(inst_master.getName())
print("-----Library cells with different sizes-----")
# Get equivalent library cells
equiv_cells = timing.equivCells(inst_master)
for equiv_cell in equiv_cells:
  print(equiv_cell.getName())

# Perform gate sizing using swapMaster
target_master = "BUFx4_ASAP7_75t_R"
target_master_ptr = db.findMaster(target_master)
inst.swapMaster(target_master_ptr)
print("----Change to the following library cell----")
print(inst.getMaster().getName())


# -------------------
# ----- Vt swap -----
# -------------------
target_master = "BUFx4_ASAP7_75t_SL"
target_master_ptr = db.findMaster(target_master)
inst.swapMaster(target_master_ptr)
print("----Change to the following library cell----")
print(inst.getMaster().getName())


# ------------------------
# --- Buffer insertion ---
# ------------------------
print("\n# --- Buffer insertion ---")

print("\n### net1 connection before buffer insertion")
get_connection("n_11046")

# Go over the insert_buffer function definition
insert_buffer("n_11046", "BUFx2_ASAP7_75t_R")
print("\n### net1 connection after buffer insertion")
get_connection("n_11046")


# -----------------------
# ---- Gate cloning -----
# -----------------------
print("\n# --- Gate cloning ---")

# Go over the clone_gate function definition:
get_inst_connection("new_buffer_1")
clone_gate("new_buffer_1", "new_buffer_1_clone")
get_inst_connection("new_buffer_1")
get_inst_connection("new_buffer_1_clone")


# ---------------------------
# --- Logic restructuring ---
# ---------------------------
print("\n# --- Logic restructuring ---")
# In this example a 4 input OR is split into 3 two input OR gates
print("### In this example a 4 input OR (g168284) is split into 3 two-input OR gates")

target_inst = 'g158311'
inst = block.findInst(target_inst)

master = 'OR2x2_ASAP7_75t_R'
master_ptr = db.findMaster(master)

# Creating new instances and nets
new_inst1 = odb.dbInst_create(block, master_ptr, "new_OR_1")
new_inst2 = odb.dbInst_create(block, master_ptr, "new_OR_2")
new_inst3 = odb.dbInst_create(block, master_ptr, "new_OR_3")
new_net1 = odb.dbNet_create(block, "new_OR_1_out_net")
new_net2 = odb.dbNet_create(block, "new_OR_2_out_net")

in_nets = []
# Getting the input, output and PG nets of original OR gate
for pin in inst.getITerms():
    sig_type = pin.getSigType()
    if pin.isOutputSignal():
        out_net = pin.getNet()
    elif pin.isInputSignal():
        in_nets.append(pin.getNet())
    elif sig_type == 'POWER':
        power_net = pin.getNet()
    elif sig_type == 'GROUND':
        gnd_net = pin.getNet()

# Connecting the PG pins of newly added OR gates
connect_pg(new_inst1,power_net,gnd_net)
connect_pg(new_inst2,power_net,gnd_net)
connect_pg(new_inst3,power_net,gnd_net)
# Connecting signal pins of OR gate 1
i = 0
for pin in new_inst1.getITerms():
    if pin.isOutputSignal():
        pin.connect(new_net1)
    elif pin.isInputSignal():
        pin.connect(in_nets[i])
        i=i+1
# Connecting signal pins of OR gate 2
for pin in new_inst2.getITerms():
    if pin.isOutputSignal():
        pin.connect(new_net2)
    elif pin.isInputSignal():
        pin.connect(in_nets[i])
        i=i+1
i = 0
# Connecting signal pins of OR gate 3
for pin in new_inst3.getITerms():
    if pin.isOutputSignal():
        pin.connect(out_net)
    elif pin.isInputSignal():
        if i:
            pin.connect(new_net2)
        else:
            pin.connect(new_net1)
            i=i+1
# Delete old inst
odb.dbInst_destroy(inst)

print("Final inst connections:")
get_inst_connection('new_OR_1')
get_inst_connection('new_OR_2')
get_inst_connection('new_OR_3')
