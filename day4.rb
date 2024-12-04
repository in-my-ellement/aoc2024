# input parsing
input = IO.readlines("inputs/4", chomp: true)

# part 1
def countInString(s) 
  s.split("").each_cons(4).count { |a| a.join.eql? "XMAS" }
end

def getAllDiagonals(m)
  # get coordinates that sum up to i for all i
  fst = (0.. (2 * m.count - 2)).map { |i|
    (0..m.count).to_a.repeated_permutation(2).filter { |p| 
      p.max < m.count and p.inject(:+) == i 
    }.map { |a| m[a[0]][a[1]] }
  }

  # flip matrix and then do it again
  snd = (0.. (2 * m.count - 2)).map { |i|
    (0..m.count).to_a.repeated_permutation(2).filter { |p| 
      p.max < m.count and p.inject(:+) == i 
    }.map { |a| m.reverse[a[0]][a[1]] }
  }

  return fst + snd
end

# rows
count = 0
count += input.map { |s| countInString(s) }.inject(:+)
count += input.map { |s| countInString(s.reverse) }.inject(:+)

# columns
cols = input.map { |s| s.split("") }.transpose.map { |a| a.join }
count += cols.map { |s| countInString(s) }.inject(:+)
count += cols.map { |s| countInString(s.reverse) }.inject(:+)

# diagonals
diags = getAllDiagonals(input.map { |s| s.split("") }).map { |a| a.join }
count += diags.map { |s| countInString(s) }.inject(:+)
count += diags.map { |s| countInString(s.reverse) }.inject(:+)

p count

# part 2
count = 0
for i in (0..input.size - 1)
  for j in (0..input[i].size - 1)
    if input[i][j] == "A" and (1..input.size - 2).cover?(i) and (1..input[i].size - 2).cover?(j)
      lDiag = ["MAS", "SAM"].include?(input[i-1][j-1] + input[i][j] + input[i+1][j+1])
      rDiag = ["MAS", "SAM"].include?(input[i-1][j+1] + input[i][j] + input[i+1][j-1])

      count += 1 if lDiag and rDiag
    end
  end
end

p count
