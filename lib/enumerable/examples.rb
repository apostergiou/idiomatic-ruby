# Checking for specific attributes
arr = [1, 3, 9]

arr.any?(&:even?)  # => false
arr.none?(&:even?) # => true

# Filtering elements
data = [1, 0, 3]

data.select(&:zero?) # => [0]

# Sorting
countries = %w(Spain Germany Greece)

countries.sort # => ['Germany', 'Greece, 'Spain']

# The lazy enumerator is useful in playing with infinite sequences
seq = (0..Float::INFINITY).lazy

# Including the Enumerable mixin
class Car
  include Enumerable

  def initialize
    @parts = %w(seats engine software)
  end

  def each
    @parts.each { |part| yield "The coolest part: #{part}" }
  end
end

my_car = Car.new
my_car.first # => 'software'
