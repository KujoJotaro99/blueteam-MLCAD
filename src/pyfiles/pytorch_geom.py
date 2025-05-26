import pandas as pd
import torch
from torch_geometric.data import Data
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="gets pin, cell, and net features using openroad API")
    parser.add_argument("-d", "--design", type=str, default="ac97_top", help="Design name")
    parser.add_argument("-p", "--platform", type=str, default="ASAP7", help="Platform name")
    args = parser.parse_args()

#need to turn netlist into a graph
cells = pd.read_csv("../../designs/{args.design}/IR_Tables/cells.csv")
#read each cell and save as a node
nets = pd.read_csv("../../designs/{args.design}/IR_Tables/nets.csv")
#read each net and save as an edge
#read node results like cell type and save as feature

