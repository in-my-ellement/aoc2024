# input parsing
data = IO.readlines("inputs/2", chomp: true).map{ |l| l.split(" ").map{ |s| s.to_i } }

def part1(arr)
  inc = arr[1] > arr[0]
  
  return false if arr.each_cons(2).map { |a| (a[1] - a[0]).abs }.max > 3

  if inc
    # make sure the rest is increasing
    return false unless arr.sort.eql? arr and arr.uniq.eql? arr
  else 
    # make sure the rest is decreasing
    return false unless arr.sort.reverse.eql? arr and arr.uniq.eql? arr
  end

  return true
end

# part 1
count = 0
data.each { |arr| count += 1 if part1(arr) }

p count

# part 2
count2 = 0
data.each { |arr|
  # check if inc or dec
  inc = arr[1] > arr[0]

  # brute force
  possible = arr.repeated_combination(arr.count - 1).to_a
  possible = possible.map {|sol| part1(sol) }.inject(false) { |before, now| before or now }

  count2 += 1 if possible
}

p count2
