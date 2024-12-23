import networkx as nx
import re

# input parsing
input = open("inputs/23", "r")
data = input.read().splitlines()
input.close()

# part 1
G = nx.Graph()
for s in data:
    nodes = re.findall("\w{2}", s)
    G.add_edge(nodes[0], nodes[1])

cliques = nx.enumerate_all_cliques(G)
print(len([g for g in cliques if len(g) == 3 and any(s.startswith("t") for s in g)]))

# part 2
print(",".join(sorted(nx.max_weight_clique(G, weight=None)[0])))
