#!/usr/bin/env bash


cd /app/MLCAD25-Contest-Scripts-Benchmarks/GL0AM/

echo "Enter golden netlist with full path:"
read golden_netlist_path
echo "Enter resynthesized netlist with full path:"
read resynthesized_netlist_path
g_filename="${golden_netlist_path##*/}"  
g_filename="${g_filename%.*}" 

r_filename="${resynthesized_netlist_path##*/}"    
r_filename="${r_filename%.*}"  


extension=".pkl"
g_out="${g_filename}${extension}"
r_out="${r_filename}${extension}"


cargo run --bin build_gatspi_graph /"$golden_netlist_path" ./gatspi/"$g_out"
cargo run --bin build_gatspi_graph /"$resynthesized_netlist_path" ./gatspi/"$r_out"

echo "Enter design top name:"
read top_name

cd gatspi/
echo "$(pwd)"
python3 runGatspi.py --top_name "$top_name" --graph0FilePath ./"$g_out" --graph1FilePath ./"$r_out" --dumpDGLGraph 1 --createStdCellLibLUT 1

