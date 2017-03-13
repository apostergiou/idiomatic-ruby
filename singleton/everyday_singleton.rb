#
# Class methods
#
# Ruby only support instance methods. The everyday class methods we use end up
# in the Singleton class.
class Foo

  def self.one () 1 end

  class << self
    def two () 2 end

    <<-DOC
      Inside the Foo's body self is Foo. So the above is the same as:

      class Foo; end
      class << Foo
        def two () 2 end
      end

      Or technically you could also just replace self with Foo inside the body,
      but this is not used usually.
    DOC
  end

  def three () 3 end

  # self here is redundant
  self.singleton_methods # => ["two", "one"]
  self.class             # => Class
  self                   # => Foo
end

#
# Mocking and testing frameworks
class Foo
  def bar?
    foobar == 1
  end

  private

  def foobar
    2
  end
end

# Pseudo code. Not an actual specific testing framework.
class FooTest
  def test_bar
    foo = Foo.new
    # The singleton class allows us to mock the private method foobar
    def foo.foobar() 1 end
    assert(foo.bar?)
  end
end
