import os
import pdn, odb, utl
from openroad import Tech, Design, Timing
import openroad as ord
from collections import defaultdict
from pathlib import Path
from liberty.parser import parse_liberty
import re
from OpenROAD_helpers import connect_pg

# caching
_LIB_CACHE = {}

# get liberty details
def _read_cell_liberty(tech_node="ASAP7"):
    if tech_node in _LIB_CACHE:
        return _LIB_CACHE[tech_node]
    lib_dir = Path(f"../../platform/{tech_node}/lib/")
    lib_files = lib_dir.glob("*.lib")
    lib_parsed_list = [parse_liberty(open(lib_file).read()) for lib_file in lib_files]
    _LIB_CACHE[tech_node] = lib_parsed_list
    return lib_parsed_list

# get drive strength
def _get_drive_strength(parsed_list, cell_name, voltage=0.7):
    best_drive_mA = 0.0
    # parse through liberty file structure
    for lib in parsed_list:
        cell = lib.get_group(cell_name)
        if not cell:
            continue
        for pin in cell.get_groups('pin'):
            if pin.get('direction') == 'output':
                for timing in pin.get_groups('timing'):
                    if timing.get('timing_type') == 'combinational':
                        for arc_name in ('cell_fall', 'cell_rise'):
                            arc = timing.get_group(arc_name)
                            if not arc:
                                continue
                            # index 1: input transitions, index 2: output cap
                            caps = arc.get_index('index_2')
                            # each column corresponds to one value of index 2
                            delays = arc.get_values()
                            if not caps or not delays:
                                continue
                            C_fF = float(caps[-1])
                            t_ps = float(delays[-1][-1])
                            if C_fF == 0:
                                continue
                            R_kohm = t_ps / C_fF
                            if R_kohm == 0:
                                continue
                            # clauclate highest sink current
                            drive_mA = voltage / R_kohm
                            if drive_mA > best_drive_mA:
                                best_drive_mA = drive_mA
    return best_drive_mA if best_drive_mA > 0 else None

# for manual resizing to something specific
def _gate_sizing_specific(inst_name, target_master_name):
    # get active design block
    block = ord.get_db_block()
    # find instance by name
    inst = block.findInst(inst_name)
    if inst is None:
        raise ValueError(f"instance '{inst_name}' not found")
    # lookup target master pointer
    db = ord.get_db()
    target_master = db.findMaster(target_master_name)
    if target_master is None:
        raise ValueError(f"master '{target_master_name}' not found")
    # perform resize
    inst.swapMaster(target_master)
    return inst.getMaster().getName()

# get equivalent cell masters for an instance
def _get_equiv_cells(design, inst_name):
    # build equiv classes once per design
    timing = Timing(design)
    timing.makeEquivCells()
    block = ord.get_db_block()
    inst = block.findInst(inst_name)
    if inst is None:
        return []
    master = inst.getMaster()
    #return list of dbMaster objects
    return timing.equivCells(master)

# resizing up or down, for gnn direction True = up/descending, direction False = down/ascending
def gate_sizing(design, inst_name, direction=True, tech = "ASAP7", voltage=0.7):
    #get liberty information
    parsed_libs = _read_cell_liberty(tech)
    # get equivalence class of masters
    equiv = _get_equiv_cells(design, inst_name)
    # calcualte drive strength of the master cell
    master_drive = {m: _get_drive_strength(parsed_libs, m.getName(), voltage=voltage) for m in equiv}
    #sort 
    sorted_m = sorted(master_drive.items(), key=lambda kv: (kv[1] if kv[1] is not None else -1), reverse=direction)
    # get current instance's drive strength
    block = ord.get_db_block()
    inst = block.findInst(inst_name)
    if inst is None:
        return inst_name
    inst_master = inst.getMaster()
    inst_drive = master_drive.get(inst_master)
    # compare with other cells
    for m, drive in sorted_m:
        if drive is None or m == inst_master:
            continue
        if direction and drive > inst_drive:
            return _gate_sizing_specific(inst_name, m.getName())
        elif not direction and drive < inst_drive:
            return _gate_sizing_specific(inst_name, m.getName())
    # if cannot go lower or higher
    return inst_master.getName()
        
# parses cell name base don asap7 naming convention
def _parse_gate_name(original_master_name):
    # split name, format GATEAxB_...
    parts = re.match(r'([A-Z]+)([0-9])x([0-9])')
    if parts:
         logic_type = parts.group(1)
         input_count = parts.group(2)
         drive_strength = parts.group(3)
         return logic_type, input_count, drive_strength
    print(f"Invalid format {original_master_name}")
    return None

# returns equivalent gate names, same drive strength to keep it simple for now but differnt input counts
def _find_equivalent_gate(original_master_name, db):
    # parse master name
    logic_type, num_inputs, drive_strength = _parse_gate_name(original_master_name)
    if logic_type is None and num_inputs is None and drive_strength is None:
        return []
    # look through master list
    for master in db.getMasters():
        master_name = master.getName()
    equivalents = []
    for master in db.getMasters():
        master_name = master.getName()
        logic_type_other, input_count_other, drive_strength_other = _parse_gate_name(master_name)
        if logic_type_other is None and input_count_other is None and drive_strength_other is None:
            continue
        if (logic_type_other == logic_type and drive_strength_other == drive_strength and input_count_other != num_inputs):
            equivalents.append(master_name)
    return equivalents

# logic restructuring by lower input count to 2 by default
def logic_restructuring(inst_name, parallel = False):
    # get design block
    db = ord.get_db()
    block = ord.get_db_block()
    # find instance object
    inst = block.findInst(inst_name)   
    if inst is None:
        print(f"Instance '{inst_name}' not found")
        return None 
    # find master cell 
    master = inst.getMaster()
    # find master cell name
    original_master_name = master.getName()
    # parse name of master
    parsed = _parse_gate_name(original_master_name)
    logic_type, num_inputs, drive_strength = parsed
    num_inputs = int(num_inputs)
    if num_inputs <= 2:
        print(f"{inst_name} already has 2 or fewer inputs; nothing to restructure.")
        return original_master_name
    # find gates with equal drive and different input counts
    equivalents = _find_equivalent_gate(original_master_name, db)
    # default policy for now is to always just donwsize to 2
    target_master_name = None
    # parse through equivalents to find next lowest
    for eq_name in equivalents:
        eq_parsed = _parse_gate_name(eq_name)
        if eq_parsed is None:
            continue
        # logic, inputs, drive
        _, eq_inputs, _ = eq_parsed
        eq_inputs = int(eq_inputs)
        # HARD CODED 2
        if eq_inputs == 2:
            target_master_name = eq_name
            break
    # if nothing valid is found
    if target_master_name is None:
        print(f"No 2-input equivalent found for {original_master_name}")
        return original_master_name
    # get master cell type
    two_input_master = db.findMaster(target_master_name)
    # get the nets for the original gate
    # example: AND 4 (A,B,C,D) to Y
    in_nets = [] # A, B, C, D
    out_net = None # Y
    power_net = None # VDD
    gnd_net = None # GND
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
    # if input or output reading failed or is empty
    if out_net is None or len(in_nets) != num_inputs:
        print("Failed to read instance connectivity.")
        return original_master_name
    # disconnect and destroy original instance
    odb.dbInst_destroy(inst)
    # build a binary tree of 2-input gates
    nets_to_combine = in_nets[:] # A, B, C, D -> CASCADING: out = (((A or B) or C) or D) || PARALLEL: out = ((A or B) or (C or D))
    intermediate_nets = []
    insts_created = []
    # loop
    gate_count = 0
    # as long as there is more than 1 unconnected net, create a gate
    while len(nets_to_combine) > 1:
        # cascading style
            # example
            # i = 0
            # pair (A,B): OR2_0 -> net0
            # nets_to_combine: [net0, C, D, E]
            # i = 1
            # pair (net0,C): OR2_1 -> net2
            # nets_to_combine: [net2, D, E]
            # i = 3
            # pair (net2, D): OR2_2 -> net3
            # nets_to_combine: [net3, E]
            # i = 4
            # pair (net3, E): OR2_3 -> out_net
        if not parallel:
            # combine two nets at a time
            net1 = nets_to_combine.pop(0)
            net2 = nets_to_combine.pop(0)
            # if theres no more nets left then reconnect current isntance output to original output
            if len(nets_to_combine) == 0:
                # last gate should output to the original output
                this_out_net = out_net
            else:
                # otherwise create an intermediate output net, input to next gate 
                this_out_net = odb.dbNet_create(block, f"{inst_name}_tree_net_{gate_count}")
                intermediate_nets.append(this_out_net)
            # new gate
            new_inst = odb.dbInst_create(block, two_input_master, f"{inst_name}_tree_{gate_count}")
            insts_created.append(new_inst)
            gate_count += 1
            # connect power/ground
            if power_net and gnd_net:
                connect_pg(new_inst, power_net, gnd_net)
            # connect pins (inputs and output)
            connected_inputs = 0
            # iterate through all instances of pins attached to this net
            for pin in new_inst.getITerms():
                # if input
                if pin.isInputSignal():
                    # assuming 2 input default just connect net 1 and net 2 for each gate
                    pin.connect(net1 if connected_inputs == 0 else net2)
                    connected_inputs += 1
                # if output
                elif pin.isOutputSignal():
                    # connect output net to the output pin
                    pin.connect(this_out_net)
        # parallel style
        else:
            # group inputs, if odd then add extra gate 
            next_nets = []
            i = 0
            n = len(nets_to_combine)
            # example
            # outer 1: 
            # # nets_to_combine: [A, B, C, D, E]
            # i = 0
            # pair (A,B): OR2_0 -> net0
            # i = 2
            # pair (C,D): OR2_1 -> net1
            # nets_to_combine: [net0, net1, E]
            # outer 2:
            # i = 0
            # pair (net0,net1): OR2_0 -> net2
            # nets_to_combine: [net2, E]
            # i = 2
            # pair (net2, E): OR2_3 -> out_net
            # parse all the nets remaining in the nets_to _ombine list
            while i < n:
                # if only one net left(odd), carry it forward as input to output gate
                if i == n - 1:
                    next_nets.append(nets_to_combine[i])
                    break
                # replace 
                net1 = nets_to_combine[i]
                net2 = nets_to_combine[i+1]
                # if this is the last round, output to out_net
                if n <= 2:
                    this_out_net = out_net
                # otherwise make intermediary net
                else:
                    this_out_net = odb.dbNet_create(block, f"{inst_name}_par_net_{gate_count}")
                    intermediate_nets.append(this_out_net)
                # create new gate
                new_inst = odb.dbInst_create(block, two_input_master, f"{inst_name}_par_{gate_count}")
                insts_created.append(new_inst)
                gate_count += 1
                # connect power/ground
                if power_net and gnd_net:
                    connect_pg(new_inst, power_net, gnd_net)
                # connect pins
                connected_inputs = 0
                for pin in new_inst.getITerms():
                    if pin.isInputSignal():
                        pin.connect(net1 if connected_inputs == 0 else net2)
                        connected_inputs += 1
                    elif pin.isOutputSignal():
                        pin.connect(this_out_net)
                # collect output net for next round
                next_nets.append(this_out_net)
                i += 2
            # update nets to combine
            nets_to_combine = next_nets
    # output
    print(f"Restructured {inst_name} ({original_master_name}) to {len(insts_created)} x 2-input {logic_type} gates. Parallel: {parallel}")
    return [inst.getName() for inst in insts_created]



    

