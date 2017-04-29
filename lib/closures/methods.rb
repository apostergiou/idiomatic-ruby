def print
  p yield
end

def hello_world
  'Hello world!'
end

print(&method(:hello_world))
