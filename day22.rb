require "set"

# input parsing
input = IO.readlines("inputs/22", chomp: true).map(&:to_i)

# part 1
def secret(n) 
  m = (n * 64) ^ n  
  m = m % 16777216
  m = (m / 32) ^ m
  m = m % 16777216
  m = (m * 2048) ^ m
  m = m % 16777216
end

p input.map { |n|
  curr = n
  2000.times { curr = secret(curr) }
  curr
}.inject(:+)

# part 2
secrets = input.map do |n|
  curr = n
  [n] + (1..2000).map { curr = secret(curr) }
end

prices = secrets.map do |a| 
  [0] + a.map { |m| m % 10 }.each_cons(2).map { |p| p[1] - p[0] }[1..-1]
end

sol = {}
prices.each_with_index do |a, i|
  seen = Set.new
  for j in 0..a.size-4
      seq = a[j..j+3]
      bananas = secrets[i][j+4] % 10
      next if seen.include? seq

      if sol.include? seq and not sol[seq].nil?
        sol[seq] += bananas
      else
        sol[seq] = bananas
      end
      seen.add seq
  end
end

p sol.values.max
