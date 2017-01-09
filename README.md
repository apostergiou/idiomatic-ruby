# Idiomatic-ruby

## Table of Contents

1. [Curly brackets and map](#curly-brackets-and-map)

## Curly brackets and map
```ruby
cake_prices = [2, 3, 5]

puts cake_prices.map { |p| p * 3.14 } # prints the cake prices
puts cake_prices.map do |p| p * 3.14 end # puts(cake_prices.map) do |n| n * 10 end
```

**[⬆ back to top](#table-of-contents)**

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
