# Заполнить массив числами фибоначчи до 100

def fib_array max_value
  ary = [1,1]
  while ary.last < max_value
    ary << ary[- 1] + ary[- 2]
  end
  ary.pop
  ary
end

p fib_array 100
