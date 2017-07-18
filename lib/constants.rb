##
# In Ruby classes and modules are constants.
module Foo
  MY_NUMBER = 42

  class FooClass
  end

  module FooModule
  end
end

puts Foo.constants.inspect # => [:MY_NUMBER, :FooClass, :FooModule]

##
# Modules have access to constants defined in their parents.
module X
  FOO = 'bar'
  module Y
    def self.output
      puts Module.nesting.inspect  # => [X::Y, X]
      puts FOO
    end
  end
end

X::Y.output # => "bar"

##
# The above inheritance is lexical.
module X2
  FOO = 'bar'
end

module X2::Y2
  def self.output
    puts Module.nesting.inspect  # => [X2::Y2]
    puts FOO
  end
end

X2::Y2.output # => uninitialized constant X2::Y2::FOO (NameError)
