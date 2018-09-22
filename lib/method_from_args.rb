# Define a method inside another's method param list
def factorial(
  n,
  redefinition = <<-RUBY,
    define_method(__method__) do |
      _ = (return 1 if n == 1; nil),
      _ = eval(redefinition),
      _ = (return n * (n -= 1; send(__method__)); nil)
    |

    end
  RUBY
  _ = eval(redefinition),
  _ = (return send(__method__); nil)
)
  # <<EMPTY BODY>>
end

p factorial(5)
