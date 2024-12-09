# input parsing
input = IO.readlines("inputs/7", chomp: true)

# part 1
$operations = [:+, :*]
def equation(s)
  sol = s.scan(/\d+/)[0].to_i
  operands = s.scan(/\d+/)[1..].map { |n| n.to_i }

  ops = $operations.repeated_permutation(operands.count - 1).to_a
  ops.filter! { |arr|
    sol == (1..operands.count-1).zip(operands[1..]).inject(operands[0]) { |total, curr| total.send(arr[curr[0] - 1], curr[1])}
  }

  return ops.empty? ? 0 : sol
end

p input.map { |s| equation(s) }.inject(:+)

# part 2
class Integer
  def concat(i)
    return (self.to_s + i.to_s).to_i
  end
end

$operations = [:+, :*, :concat]
p input.map { |s| equation(s) }.inject(:+)
