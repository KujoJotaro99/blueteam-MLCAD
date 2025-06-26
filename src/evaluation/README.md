# Script for evaluating results
This directory contains evaluation scripts for the contest and the evaluation method for users of the OpenROAD Python API. The evaluation penalties are set to 1 for this sample evaluation script. All penalties are subject to change during the alpha submission, beta submission, and final evaluation stages. The run-time penalty is not included in this sample evaluation script.


## Run evaluation
Evaluation is broken down into 2 phases.
### Phase 1: Logic Equivalence Check
Here you will be checking the logical Equivalence between the netlist provided to you by us(golden version) and the resynthesized-netlist(updated version). You will be using GL0AM to do this. You can learn more about GL0AM [here](https://github.com/NVlabs/GL0AM/tree/mlcad2025_contest_sim). This top-level shell script will automate the task for you.

```
bash Logic_Equiv_check.sh
```
#### This will ask you to add the full path to the golden netlist, resynthesized netlist, and top module name of the respective design. See the example below.
```
Enter golden netlist with full path:
app/MLCAD25-Contest-Scripts-Benchmarks/GL0AM/build_gatspi_graph/tests/adder.v
Enter resynthesized netlist with full path:
app/MLCAD25-Contest-Scripts-Benchmarks/GL0AM/build_gatspi_graph/tests/adder_altIncorrect.v
Enter design top name:
adder
```


Note: Remember the resynthesized netlist has to pass the Logic Equivalence Check to be considered for Evaluation Phase 2. 

### Phase 2: Performance improvement over baseline stats.
(Make sure you have OpenROAD built locally)
Run the following command to check the correctness of the resynthesis result and get the sample score:
- Add the name of the corresponding benchmark you want to evaluate with the "-d" flag
```
../../OpenROAD/build/src/openroad -python OpenROAD_flow.py -d <The name of the benchmark>
```
