# input parsing
input = IO.readlines("inputs/9a", chomp: true)[0].split("").map(&:to_i)

# part 1
disk = (0..input.size-1).zip(input).map { |p| Array.new(p[1], if p[0].odd? then -1 else p[0]/2 end) }.flatten
while disk.include? -1
  disk[disk.index(-1)] = disk.pop  
  disk.pop if disk[-1] == -1
end

p disk.map(&:to_i).zip(0..disk.size).map { |p| p[0] * p[1] }.inject(:+)

# part 2
disk = (0..input.size-1).zip(input).map { |p| Array.new(p[1], p[0].odd? ? -1 : p[0]/2) }
(0..disk.count { |a| not a.all?(-1) } - 1).to_a.reverse.each { |i|
  a = disk.index(disk.filter { |arr| not arr.all?(-1) }[i])
  b = disk.index { |arr| arr.size >= disk[a].size and arr.all?(-1) }
  next if b == nil or b >= a

  p disk

  m = disk[a].size
  n = disk[b].size
  disk[b] = disk[a]
  disk[a] = Array.new(m, -1)

  if n > m
    disk.insert(b+1, Array.new(n - m, -1))
  end

  (1..disk.size-1).reverse_each do |i|
    next unless disk[i].all?(-1) and disk[i-1].all?(-1)

    disk[i] = disk[i] + disk[i-1]
    disk.delete_at(i-1)
  end
}

p disk.flatten.zip(0..disk.flatten.size).map { |p| p[0] != -1 ? p[0] * p[1] : 0 }.inject(:+)
