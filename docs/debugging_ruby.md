## Find out method definition

```ruby
foo = Object.new
p foo.method(:bar).source_location
```

## Bundle open

```shell
$ bundle open whenever

$ gem pristine whenever # restore gem
```

## Super calling

```ruby
def foo
  puts method(:foo).super_method.source_location
  super
end
```

## List all methods on an object

```ruby
foo.methods
```
