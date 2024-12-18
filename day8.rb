require "matrix"

# input parsing
input = IO.readlines("inputs/8", chomp: true).map { |s| s.split("") }

# part 1
antennae = {}
input.size.times do |i|
  input[i].size.times do |j|
    next if input[i][j] == "."

    antennae[input[i][j]] = [] if antennae[input[i][j]].nil?
    antennae[input[i][j]].append(Vector[i, j])
  end
end

antinodes = []
antennae.keys.each do |k|
  pairs = antennae[k].combination(2)
  pairs.each do |p|
    diff = p[1] - p[0]
    antinodes.append(p[0] - diff)
    antinodes.append(p[1] + diff)
  end
end

p antinodes.uniq.filter { |p| (0..input.size-1).include?(p[0]) and (0..input[0].size-1).include?(p[1]) }.size

# part 2
antinodes = []
antennae.keys.each do |k|
  pairs = antennae[k].combination(2)
  pairs.each do |p|
    diff = p[1] - p[0]
    n = 1 + [input.size / diff[0], input[0].size / diff[1]].max

    (0..n).each do |i|
      antinodes.append(p[0] - i * diff)
      antinodes.append(p[1] + i * diff)
    end
  end
end

p antinodes.uniq.filter { |p| (0..input.size-1).include?(p[0]) and (0..input[0].size-1).include?(p[1]) }.size
