require "matrix"

# input parsing
input = IO.read("inputs/13").split("\n\n")

# part 1
cost = 0
input.each do |s|
  nums = s.scan(/\d+/).map(&:to_i)
  m = Matrix[[nums[0], nums[2]], [nums[1], nums[3]]]
  b = Vector[nums[4], nums[5]]
  
  next if m.determinant == 0

  x = m.inv * b
  next if not x.to_a.map { |n| n.denominator == 1 }.all?(true)

  cost += x.to_a.zip([3, 1]).map { |p| p[0] * p[1] }.inject(:+)
end

p cost

# part 2
cost = 0
input.each do |s|
  nums = s.scan(/\d+/).map(&:to_i)
  m = Matrix[[nums[0], nums[2]], [nums[1], nums[3]]]
  b = Vector.elements [nums[4], nums[5]].map { |n| 10000000000000 + n }

  next if m.determinant == 0

  x = m.inv * b
  next if not x.to_a.map { |n| n.denominator == 1 }.all?(true)

  cost += x.to_a.zip([3, 1]).map { |p| p[0] * p[1] }.inject(:+)
end

p cost
