ARGV.length > 0 ? ARGV.each { |f| puts File.read(f) } : (puts STDIN.read)
