# return inside of a lambda triggers the code outside of the lambda code

def lambda_return
  l -> { return }
  l.call

  puts 'lambda return!'
end

lambda_return # => prints `lambda return!`

# return inside of a proc triggers the code outside of the method where the proc
# is being executed

def proc_return
  p = proc { return }
  p.call

  puts 'proc return!'
end

proc_return # => prints nothing
