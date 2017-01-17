# Idiomatic-ruby

A collection of Ruby tricks and idioms.

## Table of Contents

1. [Curly brackets and map](#curly-brackets-and-map)
2. [Keyword arguments](#keyword-arguments)
3. [Singleton class](#singleton-class)
4. [Local variables on the go](#local-variables-on-the-go)
5. [Exception raising](#exception-raising)
6. [Literal constructors](#literal-constructors)
7. [Here doc](#here-doc)
8. [Syntactic sugar](#syntactic-sugar)
9. [Set](#set)

## Curly brackets and map

```ruby
cake_prices = [2, 3, 5]

puts cake_prices.map { |p| p * 3.14 }    # => prints the cake prices
puts cake_prices.map do |p| p * 3.14 end # => puts(cake_prices.map) do |n| n * 10 end
```

**[⬆ back to top](#table-of-contents)**

## Keyword arguments

Ruby 2.1 introduced required keyword arguments. If a required argument is missing(the arguments defined with a trailing colon are required), Ruby will tell us by raising ArgumentError.

```ruby
def foo(cake, bar:)
  puts bar
end

foo                   # => ArgumentError: missing keyword: bar
foo(true)             # => ArgumentError: missing keyword: bar
foo(true, 'baz')      # => ArgumentError: missing keyword: bar
foo(true, bar: 'baz') # => 'baz'
```

**[⬆ back to top](#table-of-contents)**

## Singleton class

Similar names in the community: singleton class - metaclass - eigenclass

The `class << foo` syntax opens up foo's singleton class, so you can specify methods for a *particular object*. For example `class << self` opens up self's singleton class, so that methods can be defined for the current self object.

**[⬆ back to top](#table-of-contents)**

## Local variables on the go

INFO: This is considered *bad practice*

With `foo||=[]` you can use the foo variable on the go, without initializing it.

**[⬆ back to top](#table-of-contents)**

## Exception raising

```ruby
def foo
  raise ArgumentError
rescue => e
  p e.class
end
```
The syntax lets you raise a class because it looks better, but actually instances of the exception classes are raised. 
>*Exceptions are classes, classes are constants, and constants can be namespaced*.

**[⬆ back to top](#table-of-contents)**

## Literal constructors

| Class  | Example                |
| ------ | -------                |
| String | `'foo'`                |
| Symbol | `:symbol`              |
|        | `:"symbol_with_space"` |
| Array  | `[1, 2, 3]`            |
| Hash   | `{ foo: 1, bar: 2 }`   |
| Range  | `1..10`                |
| Regexp | `/regular/`            |
| Lambda | `-> (x, y) { x * y }`  |

**[⬆ back to top](#table-of-contents)**

## Here doc

```ruby
text = <<EOM
Foo.
Bar.
EOM

p text # => "Foo.\nBar.\n"
```

```ruby
array = [1, 2, <<EOM, 3]
Foo.
Bar.
EOM

p array # => [1, 2, "Foo.\nBar.\n", 3]
```

**[⬆ back to top](#table-of-contents)**

## Syntactic sugar

* Array

```ruby
a = []
a[0, 1] = 'foo', 'bar' # => a.[]=(0, 1,['foo', 'bar'])
```

**[⬆ back to top](#table-of-contents)**

## Set

> Set implements a collection of unordered values with no duplicates. This is a hybrid of Array's intuitive inter-operation facilities and Hash's fast lookup.

```ruby
require 'set'
s1 = Set.new [1, 2]                   # -> #<Set: {1, 2}>
s2 = [1, 2].to_set                    # -> #<Set: {1, 2}>
s1 == s2                              # -> true
s1.add("foo")                         # -> #<Set: {1, 2, "foo"}>
s1.merge([2, 6])                      # -> #<Set: {1, 2, "foo", 6}>
s1.subset? s2                         # -> false
s2.subset? s1                         # -> true
```

**[⬆ back to top](#table-of-contents)**

## Resources

- [Stackoverflow ruby questions](http://stackoverflow.com/questions/tagged/ruby)
- [The Well-Grounded Rubyist](http://www.goodreads.com/book/show/3892688-the-well-grounded-rubyist)
- [Refactoring: Ruby Edition](http://www.goodreads.com/book/show/11560939-refactoring)
- [Practical Object Oriented Design in Ruby](http://www.goodreads.com/book/show/13507787-practical-object-oriented-design-in-ruby)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
