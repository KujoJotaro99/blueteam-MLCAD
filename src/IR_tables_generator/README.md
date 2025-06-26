# Intermediate file generator for MLCAD 2025 CAD Contest benchmarks
This directory contains Python scripts that generate pin and cell properties of given designs, following the CircuitOps Intermediate Representation (IR) Tables format.

## Run the script
Make sure you have OpenROAD built locally. Run the following command to get the updated timing values:
- Add the name of the benchmark with the <i>"-d"</i> flag.
  - Default is ac97_top.
- Add the technology node nae with the <i>"-t"</i> flag.
  - Default is ASAP7.
- Add the def file for which the properties has to be generated with the <i>"-def_file"</i> flag.
  - Default is ac97_top_fp.def.gz.
- Add the segement route guide file generated after global routing (use grt.writeSegments command) with the <i>"-guide_file"</i> flag. This has to be given only if generating tables for global_route stage. 
  - Default is segment_route.guide .
- Give the stage name at which IR tables are being generated using <i>"-stage"</i> flag. Options: floorplan, placement, global_route.
  - Default is floorplan.
- Add <i>"-out_dir"</i> flag to provide the output directory path to store the IR tables.
  - Default is IRs folder inside design directory.

```
# You can also import the "get_tables_OpenROAD_API" function from the "openroad_helpers.py" Python file to get the pandas DataFrame
../../OpenROAD/build/src/openroad -python generate_tables.py -d <design name> -def_file <def file path> -out_dir <output directory>
```

## Intermediate file format
The script <b>generate_tables.py</b> will generate the IR tables of the mentioned design.

For example in the <b>pin_properties.csv</b> you can find the following information regarding pins. 
```
<pin_name>,<x>,<y>,<is_in_clk>,<is_port>,<is_startpoint>,<is_endpoint>,<dir>,<maxcap>,<maxtran>,<num_reachable_endpoint>,
<cell_name>,<net_name>,<pin_tran>,<pin_slack>,<pin_rise_arr>,<pin_fall_arr>,<input_pin_cap>
```
In the <b>cell_properties.csv</b> you can find the following information regarding cells.
```
<cell_name>,<is_seq>,<is_macro>,<is_in_clk>,<x0>,<y0>,<x1>,<y1>,<is_filler>,<is_buf>,<is_inv>,<libcell_name>,
<cell_static_power>,<cell_dynamic_power>
```
