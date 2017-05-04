# Tips

## Table of contents

- [Keyword arguments](#keyword-arguments)
- [Exception raising](#exception-raising)
- [Here doc](#here-doc)
- [Regexp](#regexp)
- [Method chaining](#method-chaining)
- [Range to array](#range-to-array)
- [Block arguments](#block-arguments)
- [Struct inheritance](https://github.com/apostergiou/idiomatic-ruby/blob/master/struct_inheritance.rb)
- [Inline rescue](#inline-rescue)
- [Null object pattern](#null-object-pattern)
- [Constant scope](#constant-scope)
- [Method missing](#method-missing)
- [Environment variables](#environment-variables)
- [file paths](#file-paths)
- [puts multiple lines](#puts-multiple-lines)
- [array](#array)
- [range iteration](#range-iteration)

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

Calling `raise` without passing any arguments results in Ruby re-raising the last [exception](http://stackoverflow.com/a/7250985/2443758).

>Never rescue `Exception`, instead rescue the lowest class in the exception hierarchy you need to rescue. `Exception` will catch syntax and other compiler issues, which might result in deploying a broken application.

To summarize:

- Bad

```ruby
begin
  something()
rescue Exception => e
  ...
end
```

The above code will rescue every exception. e.g. You will suppress Ruby's signals to the operating system.

- Good

```ruby
begin
  something()
rescue => e
  ...
end

# If you don't specify any exception class Ruby assumes you mean StandartError.
begin
  something()
rescue StandartError => e
  ...
end

# A better way is to rescue specific errors e.g. rescue IOError
```

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

Ruby 2.3 introduced heredoc with a tilde:

```ruby
<<~DOC
  Cleaner indentation and no extra spaces printed
DOC
```

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

## Inline rescue

`rescue` has a single line form.

```ruby
foo = { bar: 1 }

foo[:bar].capitalize # => NoMethodError: undefined method `capitalize' for 1:Fixnum
foo[:bar].capitalize rescue 'I cannot capitalize this!!' # => "I cannot capitalize this!!"
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

## Environment variables

You can set the environment variable in a terminal:

```shell
export FOO='test'
```

Now you have access to it in your irb:

```ruby
ENV['FOO'] # => "test"
```

> Setting environment variables in a terminal will last for that session only. To set it permanently add the command to your `~/.profile` file of your machine.

**[⬆ back to top](#table-of-contents)**

## File paths

Ruby implements a `File::expand_path` method which you can use to obtain the full path to the desired file.

For example let's suppose we want the `views/hello_world.erb` path and we have a file structure like this:

my_framework/

 ├── Gemfile

 ├── Gemfile.lock

 ├── config.ru

 ├── hello_world.rb

 └── views/

        ├── index.erb
        ├── hello_world.erb
        └── not_found.erb

In this case we could use the `File::expand_path` method.

```ruby
path = File.expand_path("../hello_world.rb", __FILE__)
# => "/home/user/my_framework/views/hello_world.erb"
```

Above we can see that `__FILE__` returns the relative path to the current file(`index.erb`). This will give us the path `/path/to/my_framework/index.erb`.
So we use this path as a starting point to find the full path.

**[⬆ back to top](#table-of-contents)**

## puts multiple lines

You can use `puts` to print strings in different lines:

```ruby
puts " ", "Hello!", "Hello World!"

<<~OUTPUT

Hello!
Hello World!
=> nil
OUTPUT
```

**[⬆ back to top](#table-of-contents)**

## Array

We can create an Array with specified size and initialized with a value:

```ruby
Array.new(9, 0)
=> [0, 0, 0, 0, 0, 0, 0, 0, 0]
```

**[⬆ back to top](#table-of-contents)**

## Range Iteration

We can use the `#step` method to iterate over a range:

```ruby
range = (1..10)
range.step(2) { |x| puts x } # => 1, 3, 5, 7, 9
puts
range.step(3) { |x| puts x } # => 1, 4, 7, 10
```

**[⬆ back to top](#table-of-contents)**
