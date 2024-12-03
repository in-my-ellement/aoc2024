# input parsing
data = IO.readlines("inputs/2", chomp: true).map{ |l| l.split(" ").map{ |s| s.to_i } }

# part 1
count = 0
data.each { |arr|
  # check if it is either strictly inc. or dec.
  inc = arr[1] > arr[0]
  
  next if arr.each_cons(2).map { |a| (a[1] - a[0]).abs }.max > 3

  if inc
    # make sure the rest is increasing
    next unless arr.sort.eql? arr and arr.uniq.eql? arr
  else 
    # make sure the rest is decreasing
    next unless arr.sort.reverse.eql? arr and arr.uniq.eql? arr
  end

  count += 1
}

p count

# part 2
data.each { |arr|
  # check if inc or dec
  inc = arr[1] > arr[0]

  # iterate thru and remove one evil element
  evil = false

}

