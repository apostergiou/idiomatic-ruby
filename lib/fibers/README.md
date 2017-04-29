# Fibers

Ruby has a `Fiber` class. Fibers can yield back and forth to their calling context multiple times.

- Create a fiber with the `Fiber.new` constructor
- Run your fiber with `resume`
- Suspend the fiber and return control to the calling context with `yield`

```ruby
f = Fiber.new do
 puts "Welcome."
 Fiber.yield
 puts "Hello world!"
 Fiber.yield
 puts "Bye!"
end

f.resume
puts "Back to the fiber:"
f.resume
puts "Message from the fiber:"
f.resume
puts "That's all!"
```
