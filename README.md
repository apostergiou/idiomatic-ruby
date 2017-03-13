# Idiomatic-ruby

A collection of Ruby idioms and patterns.

## Table of Contents

1.  [Curly brackets and map](#curly-brackets-and-map)
2.  [Keyword arguments](#keyword-arguments)
3.  [Singleton class](#singleton-class)
4.  [Local variables on the go](#local-variables-on-the-go)
5.  [Exception raising](#exception-raising)
6.  [Literal constructors](#literal-constructors)
7.  [Here doc](#here-doc)
8.  [Syntactic sugar](#syntactic-sugar)
9.  [Set](#set)
10. [Hash](#hash)
11. [Enumerators vs Iterators](#enumerators-vs-iterators)
12. [Regexp](#regexp)
13. [Method chaining](#method-chaining)
14. [Range to array](#range-to-array)
15. [Block arguments](#block-arguments)
16. [dup vs clone](#dup-vs-clone)
17. [Struct inheritance](https://github.com/apostergiou/idiomatic-ruby/blob/master/struct_inheritance.rb)
18. [Binary ambersand](#binary-ambersand)
19. [Inline rescue](#inline-rescue)
20. [alias vs alias_method](#alias-vs-alias_method)
21. [block vs hash](#block-vs-hash)
22. [Null object pattern](#null-object-pattern)
23. [Constant scope](#constant-scope)
24. [Block variables](#block-variables)
25. [Method missing](#method-missing)
26. [Equality](#equality)
27. [Printing](#printing)
28. [Class variable access](#class-variable-access)
29. [tap](#tap)

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

**Note**: This is considered bad practice.

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

From the style guide:
```ruby
raise SomeException, 'message'
# Consistent with `raise SomeException, 'message', backtrace`.

# signals a RuntimeError by default
raise 'message'
```

Calling `raise` without passing any arguments results in Ruby re-raising the last exception.

>Never rescue `Exception`, instead rescue the lowest class in the exception hierarchy you need to rescue. `Exception` will catch syntax and other compiler issues, which might result in deploying a broken application.

http://stackoverflow.com/a/7250985/2443758

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

A here-document can be used for multi-line comments:

```ruby
<<-DOC
Warming up --------------------------------------
               block
     6.784k i/100ms
       block to proc     6.014k i/100ms
Calculating -------------------------------------
               block     69.994k (± 4.8%) i/s -    352.768k in   5.052372s
       block to proc     61.122k (± 3.4%) i/s -    306.714k in   5.024221s

Comparison:
               block:    69994.2 i/s
       block to proc:    61122.5 i/s - 1.15x  slower
DOC
```

Nevertheless, for multi-line comments, it is common to use:

```ruby
##
# Usually multi-line comments
# are written this way
```

**[⬆ back to top](#table-of-contents)**

## Syntactic sugar

* <a name="syntactic-sugar-array"></a>Array<sup>[[link](#syntactic-sugar-array)]</sup>

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

## Hash

* Hash iteration with each

```ruby
hash = { foo: 1, bar: 2 }

hash.each { |pair| puts pair}
```

`pair[0]` contains the key and `pair[1]` the value. Nevertheless, it is common to iterate  the hash with key and value declared explicitly:

```ruby
hash = { foo: 1, bar: 2 }

hash.each { |key, value| puts key, value }
```

NOTE: As of Ruby 1.9, the order of putting things into Hash is maintained.

**[⬆ back to top](#table-of-contents)**

## Enumerators vs Iterators

Enumerators aren't the same as Iterators. An iterator is a method that yields one or more values to a code block. An enumerator is an object.

**[⬆ back to top](#table-of-contents)**

## Regexp

In addition to the match method, Ruby also features a pattern-matching operator,
`=~` (equal sign and tilde):

```ruby
  puts 'Match!' if /foo/ =~ 'foo bar'
  puts 'Match!' if 'foo bar' =~ /foo/
```

Where `match` and `=~` differ from each other is in what they return when there is
a match:
  - `=~` returns the numerical index of the character in the string where the match started
  - `match` returns an instance of the class MatchData

For example:

```ruby
  'foo bar foomobile' =~ /foo/      # => 0
  /foo/.match('foo bar foomobile')  # => #<MatchData "foo">
```

For a detailed introduction to regular expressions consult chapter 11(`regexp`) from the book `Well-Grounded Rubyist`.

**[⬆ back to top](#table-of-contents)**

## Method chaining

Return `self` in methods that you want to enable chaining.

For example:

```ruby
class FooBar
  def options
    @options ||= []
  end
  
  def foo(args)
    options << args
    self
  end
  
  def bar(args)
    options << args
  end
end

FooBar.new().foo(1).foo(2)        # => #<FooBar:0x0055a70e45f398 @options=[1, 2]>
FooBar.new().foo(1).foo(2).bar(3) # => [1, 2, 3]

# We cannot chain #bar

FooBar.new().foo(1).foo(2).bar(3).bar(4) # => NoMethodError: undefined method `bar' for [1, 2, 3]:Array
FooBar.new().foo(1).foo(2).bar(3).foo(1) # => NoMethodError: undefined method `foo' for [1, 2, 3]:Array
```

**[⬆ back to top](#table-of-contents)**

## Range to array

```ruby
Array(1..5)  # => [1, 2, 3, 4, 5]

(1..5).to_a  # => [1, 2, 3, 4, 5]

[*1..5]      # => [1, 2, 3, 4, 5]
```

**[⬆ back to top](#table-of-contents)**

## Block arguments

- Some common ways to pass a block to a method are:

```ruby
def foo(number, &block)
  p number
  block.call
end

foo(1) { p 'bar' }

foo 1 do
  p 'bar'
end

foo(1) do
  p 'bar'
end
```

- There are two ways to incorporate blocks
  - implicit
  ```ruby
  def block_method
    return unless block_given?
    yield
  end
  ```
  - explicit
  ```ruby
  def block_method(&the_block)
    return if the_block.nil?
    the_block.call
  end
  ```
The explicit way is more direct.

**[⬆ back to top](#table-of-contents)**

## dup vs clone

- `clone` will copy the Singleton class
- `clone` will preserve the frozen state of an object

**[⬆ back to top](#table-of-contents)**

## Binary ambersand

The single ambersand(bitwise AND) in Ruby is the binary equivalent of boolean AND. e.g. `100 & 111 = 100`.

If you use the operator with an Integer then it converts the integer to its binary representation and performs the operation.
For example, you can use this operator to check for even numbers:

```ruby
def is_even?(number)
  number & 1 == 0
end
```

**[⬆ back to top](#table-of-contents)**

## Inline rescue

`rescue` has a single line form.

```ruby
foo = { bar: 1 }

foo[:bar].capitalize # => NoMethodError: undefined method `capitalize' for 1:Fixnum
foo[:bar].capitalize rescue 'I cannot capitalize this!!' # => "I cannot capitalize this!!"
```

**[⬆ back to top](#table-of-contents)**

## alias vs alias_method

- Prefer `alias_method` when aliasing methods at runtime
- Prefer `alias` when aliasing methods that are resolved at the time the alias is defined(lexical class scope)

**[⬆ back to top](#table-of-contents)**

## block vs hash

A common confusion is the following:

```ruby
foo_hash = { key: 'value' }

puts foo_hash # => works as expected

puts { key: 'value' } # => results in syntax error because Ruby thinks {} is a block

#
# Workarounds
puts {{ key: 'value' }}
puts key: 'value' # => the curly bracket are redundant, so we can drop them
```

**[⬆ back to top](#table-of-contents)**

## Null object pattern

In object-oriented computer programming, a Null Object is an object with no referenced value or with defined neutral ("null") behavior. The Null Object design pattern describes the uses of such objects and their behavior (or lack thereof).

Read more in [wikipedia](https://en.wikipedia.org/wiki/Null_Object_pattern).

`nil` values force us to use conditionals to check if a variable is nil. The Null Object pattern is based in the [Special Case pattern](https://martinfowler.com/eaaCatalog/specialCase.html) and can be used to clean up some code.

The null object pattern is relatively simple:

- Identify a recurring special case where you check for nil values
- Represent that special case as an object in its own right

Generally, anytime we are checking for the same condition over and over again, that's an indication that we should think of creating a new Object for that condition.

**[⬆ back to top](#table-of-contents)**

## Constant scope

Constants are any reference that begins with uppercase, including classes and modules. The constant scope rules are different than variable scope rules.

```ruby
module ScopeModule

  FOO = 'Outer foo'
  
  class ScopeClass
    p FOO # => Outer foo
    FOO = 'Inner foo'
    p FOO # => Inner foo
  end
  
  p FOO # => Outer foo
end
```

**[⬆ back to top](#table-of-contents)**

## Block variables

You can avoid overriding variables inside a block with this technique:

```ruby
arr = [1, 2]
foo = 42

arr.each do |bar;foo|
 foo = 10
 p bar, foo
end

# it will print 1, 10 and 2, 10

p foo # => 42
```

Nevertheless, it is better to use proper variables names than the above technique.

**[⬆ back to top](#table-of-contents)**

## Method missing

`method_missing` will capture any method call for which the receiver has no predefined method. You can override this method to add custom functionality.

```ruby
class ComputerVoice
  def speak(str)
    p "Hello #{str}!"
  end
  
  def method_missing(method_id)
    speak method_id
  end
end

foo = ComputerVoice.new
foo.what # => "Hello what!"
foo.asd  # => "Hello asd!"
```

**[⬆ back to top](#table-of-contents)**

## Equality

- Double equals

`'bar' == 'bar'` works because the String class implements a `==` method that knows how to compare strings.

You can define what it means to be equal by implementing a `==` method

e.g.
```ruby
def ==(input)
  self.attribute_1 > input.attribute_1 &&
  self.name == input.name
end
```

- Triple equals

Triple equals `===` means different things depending on the class which implements the `===` method.
In many cases it is an alias for `==`.

**[⬆ back to top](#table-of-contents)**

## Printing

Let's suppose we want to nicely format the console output.

```ruby
hash_data = {}
hash_data[:foo] = 'Hello'
hash_data[:foobar] = 'World'
hash_data[:foobarfoo] = 'Hello World!'

longest_key = hash_data.keys.max_by(&:length)

hash_data.each do |k, v|
  printf "%s # %s \n", k.to_s.ljust(longest_key.length), v
end
```

**[⬆ back to top](#table-of-contents)**

## Class variable access

A way to access class variables, is the following:

```ruby
module Foo
  extend self
  def index
    @bar = :hello
  end
end

Foo.index # => :hello

Foo.class_eval('@bar')    # => :hello
Foo.class_eval('@foobar') # => :nil
```

**[⬆ back to top](#table-of-contents)**

## Tap

`tap` executes a code block, yielding the receiver to the block and returns the receiver.

```ruby
foo = 'Hello World'.tap { |s| p s.upcase }.reverse

# Prints "HELLO WORLD"
# => "dlroW olleH"

p foo # Prints "dlroW olleH"
```

**[⬆ back to top](#table-of-contents)**

## Resources

- [Stackoverflow ruby questions](http://stackoverflow.com/questions/tagged/ruby)
- [The Well-Grounded Rubyist](http://www.goodreads.com/book/show/3892688-the-well-grounded-rubyist)
- [Refactoring: Ruby Edition](http://www.goodreads.com/book/show/11560939-refactoring)
- [Practical Object Oriented Design in Ruby](http://www.goodreads.com/book/show/13507787-practical-object-oriented-design-in-ruby)
- [Byebug](https://github.com/deivid-rodriguez/byebug/blob/master/GUIDE.md)
- [Styleguide](https://github.com/bbatsov/ruby-style-guide)
- [Blackbytes](http://www.blackbytes.info)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
