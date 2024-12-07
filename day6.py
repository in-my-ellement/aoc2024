from copy import deepcopy

# input parsing
input = open("inputs/6", "r")
data = list(map(list, filter(len, input.read().split("\n"))))

# part 1
direction = {
    "^": (-1, 0),
    ">": (0, 1),
    "v": (1, 0),
    "<": (0, -1)
}

def step(pos, mat):
    offset = direction[mat[pos[0]][pos[1]]]
    nextPos = (pos[0] + offset[0], pos[1] + offset[1])

    if nextPos[0] >= len(mat) or nextPos[0] < 0 or nextPos[1] >= len(mat[0]) or nextPos[1] < 0:
        # base case
        mat[pos[0]][pos[1]] = "X"
        return pos[0:2]

    if mat[nextPos[0]][nextPos[1]] == "#":
        # rotate
        i = list(direction.keys()).index(mat[pos[0]][pos[1]])
        mat[pos[0]][pos[1]] = list(direction.keys())[(i+1) % len(direction)]
        return step(pos, mat)

    # continue to the next position
    mat[nextPos[0]][nextPos[1]] = mat[pos[0]][pos[1]]
    mat[pos[0]][pos[1]] = "X" 

    return nextPos
    
r = data.index(list(filter(lambda arr: "^" in arr, data))[0])
c = data[r].index("^")

prev = (r, c)
curr = step(prev, data)

while curr != prev:
    prev = curr
    curr = step(prev, data)

count = 0
for i in range(0, len(data)):
    for j in range(0, len(data[i])):
        if data[i][j] == "X":
            count += 1

print(count)

# part 2
def detect_loop(obs, mat, states):
    m = deepcopy(mat)
    a = deepcopy(states)

    m[obs[0]][obs[1]] = "#"
    while len(a) < 2 or (a[-1][0:2] != a[-2][0:2] and a[-1][2] != "X"):
        # prevent going out of bounds
        offset = direction[m[a[-1][0]][a[-1][1]]]
        if a[-1][0] + offset[0] >= len(m) or a[-1][1] + offset[1] >= len(m[0]): return False

        pos = step(a[-1], m)
        a.append(pos + tuple(m[pos[0]][pos[1]]))
        if a[-1] in a[0:len(a)-1]: return True

    return False

pos = []
prev_states = []

input.seek(0)
data = list(map(list, filter(len, input.read().split("\n"))))

r = data.index(list(filter(lambda arr: "^" in arr, data))[0])
c = data[r].index("^")

prev_states.append((r, c, "^"))

count = 0
for i in range(0, len(data)):
    for j in range(0, len(data[i])):
        if data[i][j] == "^": continue
        if (i, j) != prev_states[0][0:2] and detect_loop((i, j), data, prev_states): 
            count += 1

print(count)
