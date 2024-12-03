import re

# input parsing
input = open("inputs/3a", "r")
data = input.read()

# part 1
instructions = re.findall("mul\(\d+,\d+\)", data)
pairs = map(lambda s: (int(re.findall("\d+", s)[0]), int(re.findall("\d+", s)[1])), instructions)
solution = sum(map(lambda p: p[0] * p[1], pairs))
print(solution)

# part 2
instructions = re.findall("mul\(\d+,\d+\)|do\(\)|don't\(\)", data)
print(instructions)
