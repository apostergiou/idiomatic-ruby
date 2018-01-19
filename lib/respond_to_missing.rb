# Implement #respond_to_missing to five a meta-programming defined method
# behave like a "normal" method.
class User
  def method_missing(method, *args, &block)
    if method.to_s =~ /find_(\w+)/
      puts "User #{$1}: #{args}"
    else
      super
    end
  end

  def respond_to_missing?(method, *)
    method =~ /find_(\w+)/ || super
  end
end

u = User.new # => User object
u.find_by_name "Joe" # => User by_name: ["Joe"]
u.respond_to? :find_by_name # => true
m = u.method :find_by_name # => #<Method: User#find_by_name>
m.call "Joe" # => User by_name: ["Joe"]
