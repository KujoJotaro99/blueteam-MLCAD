import os
import pdn, odb, utl
from openroad import Tech, Design, Timing
import openroad as ord
from collections import defaultdict
from pathlib import Path
from liberty.parser import parse_liberty

# caching
_LIB_CACHE = {}

# get liberty details
def _read_cell_liberty(tech_node="ASAP7"):
    if tech_node in _LIB_CACHE:
        return _LIB_CACHE[tech_node]
    lib_dir = Path(f"../../platform/{tech_node}/lib/")
    lib_files = lib_dir.glob("*.lib")
    lib_parsed_list = [parse_liberty(str(lib_file)) for lib_file in lib_files]
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
    inst_master = inst.getMaster()
    inst_drive = _get_drive_strength(parsed_libs, inst_master, voltage)
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
        
# buffer placement
def buffer_placement():
    return

