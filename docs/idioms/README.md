# Ruby idioms

## Table of Contents

- [Curly brackets and map](#curly-brackets-and-map)
- [Local variables on the go](#local-variables-on-the-go)
- [Literal constructors](#literal-constructors)
- [Syntactic sugar](#syntactic-sugar)
- [Binary ambersand](#binary-ambersand)
- [block vs hash](#block-vs-hash)
- [and operator](#and-operator)
- [Class variable access](#class-variable-access)
- [Printing](#printing)
- [Equality](#equality)
- [proc idiom](#proc-idiom)
- [super](#super)
- [new](#new)

## Curly brackets and map

```ruby
cake_prices = [2, 3, 5]

puts cake_prices.map { |p| p * 3.14 }    # => prints the cake prices
puts cake_prices.map do |p| p * 3.14 end # => puts(cake_prices.map) do |n| n * 10 end
```

**[⬆ back to top](#table-of-contents)**

## Local variables on the go

**Note**: This is considered bad practice.

With `foo||=[]` you can use the foo variable on the go, without initializing it.

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

## Syntactic sugar

* <a name="syntactic-sugar-array"></a>Array<sup>[[link](#syntactic-sugar-array)]</sup>

```ruby
a = []
a[0, 1] = 'foo', 'bar' # => a.[]=(0, 1,['foo', 'bar'])
```

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

## and operator

Because `and` has a lower precedence than `=` after the following statement, foo is equal to true:

```ruby
foo = true and false
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

## Proc idiom

The following will define a proc, which takes on parameter(x) and is executed
using the brackets notation.

```ruby
-> (x) {p x}["foo"]

# alternatively
-> (x) {p x}.call("foo")
```

**[⬆ back to top](#table-of-contents)**

## Super

`super` calls the parent method with the same arguments
`super()` calls the parent method with no arguments

**[⬆ back to top](#table-of-contents)**

## new

```ruby
class Foo
  def x
    p 'hello'
  end
end

Foo::new::x
Foo::new.x
Foo.new::x
Foo.new.x

# => All evaluate to "hello"
```

**[⬆ back to top](#table-of-contents)**
