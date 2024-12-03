import re

# input parsing
input = open("inputs/3", "r")
data = input.read()

# part 1
instructions = re.findall("mul\(\d+,\d+\)", data)
pairs = map(lambda s: (int(re.findall("\d+", s)[0]), int(re.findall("\d+", s)[1])), instructions)
solution = sum(map(lambda p: p[0] * p[1], pairs))
print(solution)

# part 2
instructions = re.findall("mul\(\d+,\d+\)|do\(\)|don't\(\)", data)

enabled = [1]
for i in range(1, len(instructions)):
    if (instructions[i] == "do()"):
        enabled.append(1)
    elif (instructions[i] == "don't()"):
        enabled.append(0)
    else:
        enabled.append(enabled[i-1])

mul_instructions = []
mul_enabled = []
for i in range(0, len(instructions)):
    if (instructions[i] != "do()" and instructions[i] != "don't()"):
        mul_instructions.append(instructions[i])
        mul_enabled.append(enabled[i])

mul_instructions = [x for i, x in enumerate(mul_instructions) if mul_enabled[i]]

pairs = map(lambda s: (int(re.findall("\d+", s)[0]), int(re.findall("\d+", s)[1])), mul_instructions)
solution = sum(map(lambda p: p[0] * p[1], pairs))
print(solution)
