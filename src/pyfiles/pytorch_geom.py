import pandas as pd
import torch
import json
import networkx as nx
from torch_geometric.data import Data
import matplotlib.pyplot as plt
from torch_geometric.utils import to_networkx
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="gets pin, cell, and net features using openroad API")
    parser.add_argument("-d", "--design", type=str, default="ac97_top", help="Design name")
    parser.add_argument("-p", "--platform", type=str, default="ASAP7", help="Platform name")
    args = parser.parse_args()

#data loading

#read each cell and save as a node
cells = pd.read_csv(f"../../designs/{args.design}/IR_Tables/cells.csv")
#read each net and save as an edge
nets = pd.read_csv(f"../../designs/{args.design}/IR_Tables/nets.csv")
#read each pin and its features
pins = pd.read_csv(f"../../designs/{args.design}/IR_Tables/pins.csv")

#load the timing digest json which contains critical paths
with open(f"../../designs/{args.design}/timing_digest.json") as f:
    critical_paths = json.load(f)

#flag every pin that appears in any critical path as a citical pin
critical_pins = set(pin.split(" ")[0] for path in critical_paths for pin in path["path"])
critical_pins_df = pins[pins['pin_name'].isin(critical_pins)]
#cap for input pins
input_pins = pins[pins['is_input'] == True]
cell_slack = input_pins.groupby('cell_name')['slack'].min().reset_index()
cell_cap = input_pins.groupby('cell_name')['cap'].max().reset_index()
cell_max_cap = input_pins.groupby('cell_name')['max_cap'].max().reset_index()

#same thing for cells
critical_cells = set(critical_pins_df['cell_name'])
critical_cells_df = cells[cells['cell_name'].isin(critical_cells)]
critical_cells_df = critical_cells_df.merge(cell_slack, on='cell_name', how='left')
critical_cells_df = critical_cells_df.merge(cell_cap, on='cell_name', how='left')
critical_cells_df = critical_cells_df.merge(cell_max_cap, on='cell_name', how='left')

#same thing for nets
critical_nets = set(critical_pins_df['net_name'])
critical_nets_df = nets[nets['net_name'].isin(critical_nets)]

#cell types encoded as a number for node features
cell_types = sorted(critical_cells_df['cell_type'].unique())
cell_type_map = {type: i for i, type in enumerate(cell_types)}
critical_cells_df = critical_cells_df.copy()
critical_cells_df['cell_type_id'] = critical_cells_df['cell_type'].copy().map(cell_type_map)

#maps cell name to its row number in the critical cells dataframe
cell2number = {name: i for i, name in enumerate(critical_cells_df['cell_name'])}

x = torch.tensor(critical_cells_df[['cell_type_id', 'x', 'y', 'slack', 'max_cap', 'cap']].values, dtype=torch.float)

edge_index = []
edge_attr = []
for _, net in critical_nets_df.iterrows():
    driver_pin = net['driver_pin']
    if pd.isna(driver_pin): continue
    driver_cell = driver_pin.split('/')[0]
    if driver_cell not in cell2number: continue
    for sink in eval(net['sink_pins']):
        sink_cell = sink.split('/')[0]
        if sink_cell in cell2number:
            edge_index.append([cell2number[driver_cell], cell2number[sink_cell]])
            #add fanout as a feature
            edge_attr.append([net['fanout']])
edge_index = torch.tensor(edge_index, dtype=torch.long).t().contiguous()
edge_attr = torch.tensor(edge_attr, dtype=torch.float)

data = Data(x=x, edge_index=edge_index, edge_attr=edge_attr)
G = to_networkx(data, to_undirected=True)
plt.figure(figsize=(8,6))
nx.draw(G, with_labels=True, node_size=700, node_color='grey')
plt.show()




