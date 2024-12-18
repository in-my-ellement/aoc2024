import math

# input parsing
input = open("inputs/11", "r")
data = [int(s) for s in input.read().split(" ")]

# part 1
solved = {}
def solve(n, s):
    if s == 0: return 1

    if n in solved and solved[n][s] != None:
        return solved[n][s]
        
    if not n in solved: 
        solved[n] = [None] * (steps + 1)

    if n == 0:
        solved[n][s] = solve(1, s - 1)
        return solved[n][s]
    elif (m := math.floor(math.log10(n)) + 1) % 2 == 0:
        fst = n // (10 ** (m / 2))
        snd = n % (10 ** (m / 2))

        solved[n][s] = solve(fst, s - 1) + solve(snd, s - 1)
        return solved[n][s]
    else:
        solved[n][s] = solve(n * 2024, s - 1)
        return solved[n][s]

steps = 25
print(sum(solve(n, 25) for n in data))

# part 2
solved = {}
steps = 75
print(sum(solve(n, 75) for n in data))
