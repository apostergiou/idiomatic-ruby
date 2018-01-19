# A Binding is a whole scope packaged as an object.
# Instances of the Binding class capture the environment bindings (variables,
# methods, and self) so they can be reused later even with in a different scope.
class Greeting
  def hello
    @simple_greeting = "hi"
    complex_greeting = "hello world"
    binding
  end
end

puts binding = Greeting.new.hello # => Binding object
puts eval("complex_greeting.concat('foo')", binding) # => "hello worldfoo"
puts binding.eval("complex_greeting") # => "hello worldfoo"
puts eval("self", binding) # => Greeting object
puts eval("instance_variable_get('@simple_greeting')", binding) # => "hi"
