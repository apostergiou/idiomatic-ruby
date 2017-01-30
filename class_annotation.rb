#
# Let's assume we have a BookSearch class. The initialize method takes a Hash of
# parameters.
class BookSearch
  def initialize(hash)
    @author_name = hash[:author_name]
    @isbn = hash[:isbn]
  end
end

#
# Now, let's assume we want the initialize method to dynamically handle any list
# of key-values.
class BookSearch
  def self.hash_initializer(*attribute_names)
    define_method(:initialize) do |*args|
      data = args.first || {}
      attribute_names.each do |attribute_name|
        instance_variable_set "@#{attribute_name}", data[attribute_name]
      end
    end
  end
  hash_initializer :author_name, :isbn
end

#
# If we need the hash_initializer for many classes we can extract it to a
# module.
module Initializers
  def hash_initializer(*attribute_names)
    define_method(:initialize) do |*args|
      data = args.first || {}
      attribute_names.each do |attribute_name|
        instance_variable_set "@#{attribute_name}", data[attribute_name]
      end
    end
  end
end

#
# We can now make the method available to the class Class.
Class.send :include, Initializers

#
# And use it in clear and clean way.
class BookSearch
  hash_initializer :author_name, :isbn
end

BookSearch.new(author_name: 'john.doe', isbn: 123)
# <BookSearch:0x005626957ce6f8 @author_name="john.doe", @isbn=12345>
