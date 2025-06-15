import os
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.data import DataLoader
from torch_geometric.nn import global_mean_pool


def load_subgraphs(subgraph_dir):
    files = [os.path.join(subgraph_dir, f) for f in os.listdir(subgraph_dir) if f.endswith('.pt')]
    subgraphs = [torch.load(f, weights_only=False) for f in files]
    return subgraphs

from torch_geometric.nn import GCNConv

class NetGNN(nn.Module):
    def __init__(self, in_channels, hidden_channels):
        super().__init__()
        self.conv1 = GCNConv(in_channels, hidden_channels)
        self.conv2 = GCNConv(hidden_channels, hidden_channels)
        self.lin = nn.Linear(hidden_channels, 1)

    def forward(self, data):
        x, edge_index, batch = data.x, data.edge_index, data.batch
        x = self.conv1(x, edge_index)
        x = F.relu(x)
        x = self.conv2(x, edge_index)
        x = F.relu(x)
        # Global mean pooling for graph-level output
        x = global_mean_pool(x, batch)
        out = self.lin(x).squeeze(-1)
        return out

def main():
    subgraph_dir = "../../designs/ac97_top/subgraphs" 
    subgraphs = load_subgraphs(subgraph_dir)
    print(f"Loaded {len(subgraphs)} subgraphs.")

    random_state = torch.Generator().manual_seed(42)
    indices = torch.randperm(len(subgraphs), generator=random_state).tolist()
    split = int(0.8 * len(subgraphs))
    train_data = [subgraphs[i] for i in indices[:split]]
    test_data = [subgraphs[i] for i in indices[split:]]

    batch_size = 8
    train_loader = DataLoader(train_data, batch_size=batch_size, shuffle=True)
    test_loader = DataLoader(test_data, batch_size=batch_size)

    in_channels = train_data[0].x.shape[1]
    model = NetGNN(in_channels=in_channels, hidden_channels=32)
    optimizer = torch.optim.Adam(model.parameters(), lr=0.01)
    criterion = nn.BCEWithLogitsLoss()

    epochs = 20
    for epoch in range(epochs):
        model.train()
        total_loss = 0
        for batch in train_loader:
            optimizer.zero_grad()
            out = model(batch)
            labels = batch.y.float()
            loss = criterion(out, labels)
            loss.backward()
            optimizer.step()
            total_loss += loss.item()
        print(f"Epoch {epoch+1}/{epochs}, Loss: {total_loss/len(train_loader):.4f}")

    model.eval()
    correct = total = 0
    with torch.no_grad():
        for batch in test_loader:
            out = model(batch)
            preds = (torch.sigmoid(out) > 0.5).float()
            correct += (preds == batch.y).sum().item()
            total += batch.num_graphs
    print(f"Test Accuracy: {correct/total:.2%}")

if __name__ == "__main__":
    main()
