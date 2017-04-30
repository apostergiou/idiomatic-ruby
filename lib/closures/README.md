# Ruby closures

There are 4 types of closures in Ruby:

1) block

2) proc

3) lambda

4) method

A simple explanation of closures: Closures are ways of grouping and packaging code we want to run at a later point.


## Proc method

The `proc` method takes a block and returns a Proc object. Thus, you can use it
instead of `Proc.new` and get the same result.

```ruby
proc { puts 'Hello world!' }

Proc.new  { puts 'Hello world' }
```

## Callable objects

Ruby provides some alternatives in using the `call` method to call callable objects:

```ruby
mult = lambda {|x,y| x * y }

# If there are no arguments, leave the brackets empty
twelve = mult[3,4]

# You can also call callable objects using the () method
twelve = mult.(3,4)
```

## Differences between Blocks and Procs

- Procs are objects

This lets us assign them to variables, call methods on them and they can also return self.

- Blocks are not objects

Blocks are tuned to be performant. They neither have a callable interface nor they respond to any methods.

- You can pass multiple procs to methods but only one block

## Differences between Procs and Lambdas

Lambdas and procs are both Proc objects.

- Lambdas check the number of arguments

```ruby
l = lambda { |foo| p foo }
l.call(1) # => prints 1
l.call(1, 2) # => ArgumentError

p = Proc.new { |foo| p foo }
p.call(1) # => prints 1
p.call(1, 2) # => returns nil
```

- Differences regarding the `return` keyword

## Methods as closures

The method `method` makes methods usable in place of blocks, procs and lambdas.
