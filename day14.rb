require "matrix"

# input parsing
input = IO.readlines("inputs/14", chomp: true).map do |s|
  n = s.scan(/-?\d+/).map(&:to_i)
  [Vector[n[0], n[1]], Vector[n[2], n[3]]]
end

# part 1
$x = 101
$y = 103

def state(s, t)
  s.map do |p|
    f = p[0] + t * p[1]
    f[0] = f[0] % $x
    f[1] = f[1] % $y
    f
  end
end

def score(s, t)
  result = state(s, t)
  [:<, :>].repeated_permutation(2).map { |o|
    result.count { |p| p[0].send(o[0], ($x-1)/2) and p[1].send(o[1], ($y-1)/2) }
  }.inject(:*)
end

def printState(s, t)
  result = state(s, t)
  for i in 0..$x
    for j in 0..$y
      if result.include? Vector[i, j]
        print "#"
      else
        print "."
      end
    end
    puts ""
  end
end

p score(input, 100)

# part 2
scores = (0..20000).map { |t| score(input, t) }
p scores.index scores.min
printState(input, scores.index(scores.min))
