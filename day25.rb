# input parsing
input = IO.read("inputs/25").split("\n\n")

locks = input.filter { |s| s.split("\n")[0].split("").all?("#") }.map(&:split)
keys = input.filter { |s| s.split("\n")[0].split("").all?(".") }.map(&:split)

# part 1
lock_patterns = locks.map do |l|
  l.map { |s| s.split("") }.transpose.map { |a| a.count("#") - 1 } 
end

key_patterns = keys.map do |k|
  k.map { |s| s.split("") }.transpose.map { |a| a.count("#") - 1 }
end

p lock_patterns.product(key_patterns).map { |a| 
  a.transpose.map { |p| p.inject(:+) } 
}.filter { |a|
  a.all? { |n| n <= 5}
}.count
