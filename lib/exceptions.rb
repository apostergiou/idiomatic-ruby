# Rescues exceptions using pattern matching.
def matching(&block)
  Class.new do
    def self.===(error_instance)
      @block.call(error_instance)
    end
  end.tap { |c| c.instance_variable_set(:@block, block) }
end

begin
  raise "Match"
rescue matching { |e| e.message =~ /^Mat/ }
  puts "Rescued!"
end
