# input parsing
input = IO.read("inputs/5").split("\n\n")
rules = input[0].split("\n").map { |s| s.scan(/\d+/)[0..1].map { |c| c.to_i } }
order = input[1].split("\n").map { |s| s.scan(/\d+/).map { |c| c.to_i } }

# part 1
def preceding(a, b, arr)
  for i in 0..arr.count-1
    next unless arr[i] == a  
    (0..i).to_a.each { |i| return false if arr[i] == b }
  end
  return true
end

p order.filter { |a|
  a.map { |i| 
    !rules.map { |p| preceding(p[0], p[1], a) }.include?(false)
  }.inject(true) {|a, b| a and b}
}.map { |a| a[a.count/2] }.sum

# part 2 
sum = 0
order.each { |a|
  broken = rules.filter { |p| !preceding(p[0], p[1], a) }
  next if broken.empty?

  b = a.clone
  while !broken.empty?
    i1 = b.index(broken[0][0])
    i2 = b.index(broken[0][1])

    temp = b[i1]
    b[i1] = b[i2]
    b[i2] = temp

    broken = rules.filter { |p| !preceding(p[0], p[1], b) }
  end
  sum += b[b.count/2]
}

p sum
