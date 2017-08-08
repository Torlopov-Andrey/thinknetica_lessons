# Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D)
# и корни уравнения (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран.
#При этом возможны следующие варианты:
#  Если D > 0, то выводим дискриминант и 2 корня
#  Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#  Если D < 0, то выводим дискриминант и сообщение "Корней нет"
#  Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru).

# Для вычисления квадратного корня, нужно использовать
# Math.sqrt
# Math.sqrt(16) # => вернет 4, т.е. квадратный корень из 16.

def input_data count
  ary = Array.new(count) do |x|
    print "Input #{x+1} value: "
    gets.chomp.to_f
  end
end

def solve_quadratic_equation coefficients
  d = coefficients[1] ** 2.0 - 4.0 * coefficients[0] * coefficients[2]
  sqrt_d = Math.sqrt(d)
  return ["Roots are not present"] if d < 0
  return [-0.5 * coefficients[1] / coefficients[0]] if d == 0
  return [-0.5 * (coefficients[1] + sqrt_d) / coefficients[0],
          -0.5 * (coefficients[1] - sqrt_d) / coefficients[0]]
end

coefficients = input_data 3
p solve_quadratic_equation coefficients
