# Core methods and examples

## Table of Contents

- [Set](#set)
- [Hash](#hash)
- [Enumerators vs Iterators](#enumerators-vs-iterators)
- [dup vs clone](#dup-vs-clone)
- [alias vs alias_method](#alias-vs-alias_method)
- [tap](#tap)
- [refine](#refine)

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

## dup vs clone

- `clone` will copy the Singleton class
- `clone` will preserve the frozen state of an object

**[⬆ back to top](#table-of-contents)**

## alias vs alias_method

You can create an alias for a method in two ways:

```ruby
class Bar
  alias old_foo foo
end

class Bar
  alias_method :old_foo, :foo
end
```

The arguments to `alias` don't have a comma between them. Tha's because `alias` is a keyword. In comparison `alias_method` is a method, so it needs objects rather than bare method names as its arguments. It can take symbols or strings.

- Prefer `alias_method` when aliasing methods at runtime
- Prefer `alias` when aliasing methods that are resolved at the time the alias is defined(lexical class scope)

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

## Refine

You can use refinements to affect core behavior. The effect of refinement is temporary and stops when the class in which we are using the refinement ends.

e.g:

```ruby
module Speak
  refine String do
    def shout
      self.upcase
    end
  end
end

class Person
  attr_accessor :name

  using Speak
  def announce
    puts "Announcing: #{name.shout}"
  end
end

apostolis = Person.new
apostolis.name = 'Apostolis'
apostolis.announce # => Announcing APOSTOLIS
```

**[⬆ back to top](#table-of-contents)**
