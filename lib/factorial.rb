# Ruby has no factorial function in the standard library.
# We will implement some.
class Fixnum
  # implementation with inject
  def inject_factorial
    (1..self).inject(:*) || 1
  end

  # implementation with reduce
  def reduce_factorial
    (1..self).reduce(1, :*)
  end

  # iterative implementation
  def iterative_factorial
    f = 1
    (1..self).step do |i|
      f *= i
    end

    f
  end

  # recursive implementation
  def recursive_factorial
    self <= 1 ? 1 : self * (self - 1).recursive_factorial
  end
end

require 'minitest/autorun'

class Tests < MiniTest::Unit::TestCase
  def test_inject_factorial
    assert_equal 120, 5.inject_factorial
  end

  def test_reduce_factorial
    assert_equal 120, 5.reduce_factorial
  end

  def test_iterative_factorial
    assert_equal 120, 5.iterative_factorial
  end

  def test_recursive_factorial
    assert_equal 120, 5.recursive_factorial
  end
end
