 # Программа запрашивает у пользователя 3 стороны треугольника и определяет, является
 # ли треугольник прямоугольным, используя теорему Пифагора (www-formula.ru) и выводит
 # результат на экран. Также, если треугольник является при этом равнобедренным
 # (т.е. у него равны любые 2 стороны), то дополнительно выводится информация о том,
 # что треугольник еще и равнобедренный. Подсказка: чтобы воспользоваться теоремой
 # Пифагора, нужно сначала найти самую длинную сторону (гипотенуза) и сравнить ее значение
 # в квадрате с суммой квадратов двух остальных сторон. Если все 3 стороны равны, то
 # треугольник равнобедренный и равносторонний, но не прямоугольный.

def input_data count
  ary = Array.new(count) do |x|
    print "Input #{x+1} value: "
    gets.chomp.to_f
  end
end

def right_triangle sides
  equilateral_triangle = sides.uniq.count == 1
  return 'Triangle is equilateral.' if equilateral_triangle
  sides.sort!.reverse!
  isosceles_triangle = sides.uniq.count == 2

  is_right_triangle = sides[0] ** 2 == sides[1] ** 2 + sides[2] ** 2

  result = if is_right_triangle
             'Triangle is right'
           else
             'Triangle is not right'
           end
  result
end

triangle_sides = input_data 3
puts right_triangle triangle_sides
