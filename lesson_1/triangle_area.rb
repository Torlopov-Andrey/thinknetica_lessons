# Площадь треугольника можно вычилсить, зная его основание (a) и
# высоту (h) по формуле: 1/2*a*h. Программа должна запрашивать основание
# и высоту треуголиника и возвращать его площадь.

def triangle_area
  print "Input base: "
  base = gets.chomp.to_f
  print "Input height: "
  height = gets.chomp.to_f
  0.5 * base * height
end

puts "Area is #{triangle_area}"
