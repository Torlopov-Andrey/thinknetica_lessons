# Заполнить массив числами фибоначчи до 100

def fib_array n
  ary = Array.new(n)
  ary[0] = 1
  ary[1] = 1
  (2..n).each do |i|
    ary[i] = ary[i - 1] + ary[i - 2]
  end
  ary
end

p fib_array 100
