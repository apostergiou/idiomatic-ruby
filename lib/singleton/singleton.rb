foobar = []

# The method definition creates a method that only exists for a single object.
# As a result other objects of the Array class do not have this size method,
# but they are using the one defined in the Array class.
def foobar.size
  'Hello World!'
end

foobar.size  # => "Hello World!"
foobar.class # => Array

bizbat = []
bizbat.size  # => 0

# When we added the size method to the specific object above, Ruby inserted a
# new anonymous class into the inheritance hierarchy. This anonymous class, the
# singleton class, will act as a container to hold the defined method and
# other methods defined this way.

# Examples

#
# Using extend to add methods to an object from a module
module Foo
  def foo
    'Hello World!'
  end
end

foobar = []
foobar.extend(Foo)
foobar.singleton_methods # => ["foo"]

#
# Using the class keyword
foobar = []

# Open the singleton class for the foobar object
class << foobar
  def foo
    'Hello World!'
  end
end

foobar.singleton_methods # => ["foo"]

#
# Defining a method inside an instance_eval call will create a singleton class
foobar = []

foobar.instance_eval <<EOT
  def foo
    "Hello World!"
  end
EOT

foobar.singleton_methods # => ["foo"]
