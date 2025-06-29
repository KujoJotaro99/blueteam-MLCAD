import os
import pandas as pd
import torch
import json
import random
import networkx as nx
from torch_geometric.data import Data
from torch_geometric.utils import to_networkx
import argparse
import matplotlib.pyplot as plt
from collections import deque 

#function to load design IR results
def load_tables(design):
    cells = pd.read_csv(f"../../designs/{design}/IR_Tables/cells.csv")
    nets = pd.read_csv(f"../../designs/{design}/IR_Tables/nets.csv")
    pins = pd.read_csv(f"../../designs/{design}/IR_Tables/pins.csv")
    return cells, nets, pins

#make entire design graph
def build_graph(cells, nets):
    #empty directed graph
    G = nx.DiGraph()
    #parse cells csv to create cell name as the node
    for _, row in cells.iterrows():
        G.add_node(row['cell_name'])
    #parse nets csv to create pins as features
    for _, row in nets.iterrows():
        #driver pin
        driver_pin = row['driver_pin']
        if pd.isna(driver_pin):
            continue
        #formatted with cellName/pinName
        driver_cell = driver_pin.split('/')[0]
        if driver_cell not in G:
            continue
        #sink pins is a list format []
        for sink in eval(row['sink_pins']):
            sink_cell = sink.split('/')[0]
            if sink_cell in G:
                #adds edge driving one cell from another cell
                G.add_edge(driver_cell, sink_cell, net_name=row['net_name'])
    return G

#make dictionary of cell and net features
def build_feature_maps(cells, pins, nets):
    #sorts cell type (AND, NOT, INV) into a number for gnn representation
    #gets all unique different types of cells listed in the csv file, i was gonna just do set() instead of unique() but i apparently this is recommended for pandas
    cell_types = sorted(cells['cell_type'].unique())
    #assigns a number to each cell type in format type: i
    cell_type_map = {type: i for i, type in enumerate(cell_types)}
    #dont mess with original data frame
    cells = cells.copy()
    #replace cell type field with the numbers instead of the actual name
    cells['cell_type_id'] = cells['cell_type'].map(cell_type_map)

    #add pin features
    min_slack = pins.groupby('cell_name')['slack'].min() #lowest is worst
    max_cap = pins.groupby('cell_name')['cap'].max() #highest is worst
    max_max_cap = pins.groupby('cell_name')['max_cap'].max() #highest is worst
    #dictionary for features of each cell
    #cell_features = {row['cell_name']: row.to_dict() for _, row in cells.iterrows()}
    feature_map = {}
    for _, row in cells.iterrows():
        name = row['cell_name']
        feature_vector = [
            row['cell_type_id'], row['x'], row['y'],
            float(min_slack.get(name, 0)),
            float(max_cap.get(name, 0)),
            float(max_max_cap.get(name, 0))
        ]
        feature_map[name] = feature_vector
    #net features, converts entire row as a feature
    net_features = {row['net_name']: row.to_dict() for _, row in nets.iterrows()}
    return feature_map, net_features

#threshold: slack < 0 means violation
def label_violation(subG, pins, threshold=0):
    #for each node in subGraph, check if any pin has slack < threshold
    node_names = list(subG.nodes)
    p = pins[pins['cell_name'].isin(node_names)]
    min_slack = p['slack'].min()
    if pd.isnull(min_slack):
        return 0  # treat as non-violated if no pins/slack found
    return int(min_slack < threshold)

#convert subgraph to pygraph
def subgraph_to_pygdata(sg, feature_map, net_features):
    #map all nodes to a index, so convert to list
    node_names = list(sg.nodes)
    #get all nodes which are cells in a map
    node_map = {cell: i for i, cell in enumerate(node_names)}
    x = torch.tensor([feature_map[n] for n in node_names], dtype=torch.float)

    edge_index = []
    edge_attr = []
    #each edge has driver, sink, and net features
    for src, tgt, data in sg.edges(data=True):
        edge_index.append([node_map[src], node_map[tgt]])
        net_name = data.get('net_name', None)
        fanout = net_features[net_name]['fanout'] if net_name in net_features else 0
        edge_attr.append([float(fanout)])
    #if the graph has edges
    if edge_index:
        #.t transposes from row column to column row
        #[source1, target1]
        #[source2, target2]
        #this becomes, as pyG expects it this way
        #[source1, source2]
        #[target1, target2]
        edge_index = torch.tensor(edge_index, dtype=torch.long).t().contiguous() #i have no idea what contiguous does but its in the docs and recommended
        edge_attr = torch.tensor(edge_attr, dtype=torch.float)
    else:
        #still create an empty tensor that matches expected format
        #2 rows, no columns since no edges
        edge_index = torch.empty((2, 0), dtype=torch.long)
        #no edges, 1 column with fanout
        edge_attr = torch.empty((0, 1), dtype=torch.float)
    return Data(x=x, edge_index=edge_index, edge_attr=edge_attr)

#get a small subgraph of main design graph
def sample_random_subgraph(G, pins, min_size=4, max_size=12, critical=False, threshold=0, max_attempts=10):
    total = G.number_of_nodes()
    if total < min_size:
        return None

    for _ in range(max_attempts):
        #determine seed node
        if critical:
            #find cells with slack<threshold
            slack_map = pins.groupby('cell_name')['slack'].min()
            viol_cells = [c for c, s in slack_map.items() if s < threshold]
            if not viol_cells:
                return None
            seed = random.choice(viol_cells)
        else:
            #random starting node
            seed = random.choice(list(G.nodes()))

        #bfs to collect nodes
        visited = {seed}
        queue = deque([seed])
        target = random.randint(min_size, min(max_size, total))
        while queue and len(visited) < target:
            u = queue.popleft()
            nbrs = list(G.successors(u)) + list(G.predecessors(u))
            random.shuffle(nbrs)
            for v in nbrs:
                if v not in visited:
                    visited.add(v)
                    queue.append(v)
                    if len(visited) >= target:
                        break
        subG = G.subgraph(visited).copy()
        #check violation status
        label = label_violation(subG, pins, threshold)
        if (critical and label == 1) or (not critical and label == 0):
            return subG
    return None

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Sample subgraphs with features for GNN training")
    parser.add_argument("-d", "--design", type=str, default="ac97_top", help="Design name")
    parser.add_argument("-n", "--num_subgraphs", type=int, default=100, help="How many subgraphs to sample")
    parser.add_argument("-c", "--critical_ratio", type=float, default=0.5, help="fraction of critical subgraphs")
    args = parser.parse_args()

    #load everything
    cells, nets, pins = load_tables(args.design)
    #build the graph
    G = build_graph(cells, nets)
    #make feature map
    feature_map, net_features = build_feature_maps(cells, pins, nets)

    #sample subgraphs, get PyG data and label
    pyg_samples = []
    for i in range(args.num_subgraphs):
        if random.random() < args.critical_ratio:
            sg = sample_random_subgraph(G, pins, min_size=4, max_size=12, critical=True)
        else:
            sg = sample_random_subgraph(G, pins, min_size=4, max_size=12, critical=False)
        if sg is None:
            continue
        label = label_violation(sg, pins)  # 1 if violated, 0 otherwise
        pyg_data = subgraph_to_pygdata(sg, feature_map, net_features)
        pyg_data.y = torch.tensor([label], dtype=torch.float)
        pyg_samples.append(pyg_data)

        #graphic
        # G_nx = to_networkx(pyg_data, to_undirected=True)
        # plt.figure(figsize=(4,3))
        # nx.draw(G_nx, with_labels=True)
        # plt.show()

        print(f"Subgraph {i}: nodes={pyg_data.num_nodes}, edges={pyg_data.num_edges}, label={label}")

    #save directory
    save_dir = f"../../designs/{args.design}/subgraphs"
    os.makedirs(save_dir, exist_ok=True)
    for i, pyg_data in enumerate(pyg_samples):
        torch.save(pyg_data, f"{save_dir}/subgraph_{i}.pt")
    print(f"saved {len(pyg_samples)} subgraphs in {save_dir}/")
    print(f"Total subgraphs sampled: {len(pyg_samples)}")
