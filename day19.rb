# input parsing
input = IO.read("inputs/19").split("\n\n")

patterns = input[0].split(", ")
desired = input[1].split("\n")

# part 1
$solved = {}
def possible(s, patterns)
  return true if $solved[s] or s.empty?
  return false if $solved[s] == false

  pos = patterns.map(&:size).uniq.map { |l|
    suffixes = patterns.filter { |p| p.size == l }
    sub = s[0..-l-1]

    suffixes.map { |suf| sub + suf }.any? { |str| str == s } and possible(sub, patterns)
  }.any?(true)

  $solved[s] = pos
  return pos
end

p desired.map { |s| possible(s, patterns) ? 1 : 0 }.inject(:+)

# part 2
$solved = {"" => 1}
def count(s, patterns)
  return $solved[s] if $solved.include?(s)

  sum = patterns.map(&:size).uniq.map { |l|
    suffixes = patterns.filter { |p| p.size == l }
    sub = s[0..-l-1]
  
    prev = count(sub, patterns) 
    curr = suffixes.map { |suf| sub + suf }.count { |str| s == str }
    if prev > 0 and curr > 0
      prev * curr
    else
      0
    end
  }.inject(:+)
  
  $solved[s] = sum
  return sum
end

p desired.map { |s| count(s, patterns) }.inject(:+)
