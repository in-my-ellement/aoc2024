require "matrix"

# input parsing
input = IO.readlines("inputs/14", chomp: true).map do |s|
  n = s.scan(/-?\d+/).map(&:to_i)
  [Vector[n[0], n[1]], Vector[n[2], n[3]]]
end

# part 1
x = 101
y = 103
finalPos = input.map do |p| 
  f = p[0] + 100 * p[1]
  f[0] = f[0] % x
  f[1] = f[1] % y
  f
end

p [:<, :>].repeated_permutation(2).map { |o| 
  finalPos.count { |p| p[0].send(o[0], (x-1)/2) and p[1].send(o[1], (y-1)/2) }
}.inject(:*)

# part 2
def state(s, n) 
  s.map do |p|
    f = p[0] + n * p[1]
    f[0] = f[0] % x
    f[1] = f[1] % y
  end
end

def printState(a)
  x.times do |i|
    y.times do |j|
      if a.include?(Vector[i, j]) then puts "#" else puts "." end
    end
  end
end

(0..10).each { |i| printState(state(input, i)) }
