# Ruby closures

There are 4 types of closures in Ruby:

1) block

2) proc

3) lambda

4) method

A simple explanation of closures: Closures are ways of grouping and packaging code we want to run at a later point.

## Differences between Blocks and Procs

1. Procs are objects

This lets us assign them to variables, call methods on them and they can also return self.

2. You can pass multiple procs to methods but only one block

## Differences between Procs and Lambdas

Lambdas and procs are both Proc objects.

1. Lambdas check the number of arguments

```ruby
l = lambda { |foo| p foo }
l.call(1) # => prints 1
l.call(1, 2) # => ArgumentError

p = Proc.new { |foo| p foo }
p.call(1) # => prints 1
p.call(1, 2) # => returns nil
```

2. Differences regarding the `return` keyword

## Methods as closures

The method `method` makes methods usable in place of blocks, procs and lambdas.

