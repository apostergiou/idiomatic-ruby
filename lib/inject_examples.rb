#
# Sum numbers
#
# The first time the block executes the acc will have a value of 0 and the elem
# argument will have a value of 1.
#
# The second time the result of the previous block execution, will be yielded
# as the acc, and the second element of the array will be
# yielded as the elem argument.
#
# At the end of the process, inject returns the accumulator(the acc argument)
#
# NOTE: The argument to inject is optional.
[1, 2, 3].inject(0) { |acc, elem| acc + elem } # => 6

#
# Hash operations
#
array = [[:low_price, 5], [:high_price, 10]]
array.inject({}) do |acc, elem|
  acc[elem.first] = elem.last
  acc
end

# The above is the same as:
array.to_h
# or:
Hash[array]

# You can use inject for more complex operations:
array.inject({}) do |acc, elem|
  acc[elem.first.to_s.upcase] = elem.last.to_s
  acc
end

#
# Array operations
#
[1, 2, 3, 4].inject([]) do |acc, elem|
  acc << elem.to_s if (elem % 2).zero?
  acc
end

# Nevertheless, I think there are more clean alternatives:
[1, 2, 3, 4].map { |n| n.to_s if (n % 2).zero? }.compact

[1, 2, 3, 4].find_all { |n| (n % 2).zero? }.map(&:to_s)
