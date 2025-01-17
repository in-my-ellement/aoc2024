import networkx as nx
import itertools as it

# input parsing
input = open("inputs/10", "r")
data = list(map(list, filter(len, input.read().split("\n"))))
input.close()

G = nx.DiGraph()
for i in range(0, len(data)):
    for j in range(0, len(data[i])):
        G.add_node((i, j), height=int(data[i][j]))

# part 1
for i in range(0, len(data)):
    for j in range(0, len(data[i])):
        if (i > 0 and G.nodes[(i-1, j)]["height"] - int(data[i][j]) == 1):
            G.add_edge((i, j), (i-1, j)) 

        if (i < len(data)-1 and G.nodes[(i+1, j)]["height"] - int(data[i][j]) == 1):
            G.add_edge((i, j), (i+1, j)) 

        if (j > 0 and G.nodes[(i, j-1)]["height"] - int(data[i][j]) == 1):
            G.add_edge((i, j), (i, j-1)) 

        if (j < len(data[i])-1 and G.nodes[(i, j+1)]["height"] - int(data[i][j]) == 1):
            G.add_edge((i, j), (i, j+1)) 

# part 1
sources = [node for node in G.nodes if G.nodes.data()[node]["height"] == 0]
targets = [node for node in G.nodes if G.nodes.data()[node]["height"] == 9]
print(len([pair for pair in it.product(sources, targets) if nx.has_path(G, pair[0], pair[1])]))

# part 2
paths = [list(nx.all_simple_paths(G, node, targets)) for node in sources]
print(sum([len(path) for path in paths]))
