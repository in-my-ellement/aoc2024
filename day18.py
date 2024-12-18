import networkx as nx
import re

# input parsing
input = open("inputs/18", "r")
data = [(int(d[0]), int(d[1])) for s in input.readlines() if (d := re.findall("\d+", s)) is not None]
input.close()

# part 1
G = nx.Graph()
for i in range(0, 71):
    for j in range(0, 71):
        if (i, j) in data[0:1024]: continue
        
        G.add_node((i, j))
        if (i-1, j) in G: G.add_edge((i, j), (i-1, j))
        if (i, j-1) in G: G.add_edge((i, j), (i, j-1))

print(-1 + len(next(nx.shortest_simple_paths(G, (0, 0), (70, 70)))))

# part 2
H = nx.Graph()
for i in range(0, 71):
    for j in range(0, 71):
        H.add_node((i, j))
        if (i-1, j) in H: H.add_edge((i, j), (i-1, j))
        if (i, j-1) in H: H.add_edge((i, j), (i, j-1))

for i in range(0, len(data)):
    H.remove_node(data[i])
    if not nx.has_path(H, (0, 0), (70, 70)):
        print(data[i])
        break
