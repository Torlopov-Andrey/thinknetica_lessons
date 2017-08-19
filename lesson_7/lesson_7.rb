# line_num = 0
# File.open('text.txt').each do |line|
#   puts "#{line_num += 1}: #{line}"
# end

# a = Proc.new { |x| x = x * 10; puts x }
# a.call 3

# b = lambda { |x| x = x**2; puts x }
b = ->(x) { puts x }
b.call(3)
