#
# Structs can be used to get rid of the initialization method, by subclassing
# your classes from a Struct object.
#
# This may be considered bad practice as:
#   - a struct traditionally suggest a data structure
#   - the encapsulation is poor(only public accessors are available)
class Meeting < Struct.new(:attendees)
  def attendees_count
    attendees.length
  end
end

# The attendees is a public accessor
puts Meeting.new(['foo', 'bar']).attendees       # => prints foo and bar
puts Meeting.new(['foo', 'bar']).attendees_count # => prints 2
