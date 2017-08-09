 # Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
 # Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть
 # високосным. (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday
 # или Date#leap?) Алгоритм опредления високосного года: www.adm.yar.ru

def input_data
  print "Input day: "
  d = gets.chomp.to_i
  print "Input month: "
  m = gets.chomp.to_i
  print "Input year: "
  y = gets.chomp.to_i
  [d, m, y]
end

d, m, y = input_data

def leap_year? year
  return true if year % 400 == 0
  return false if year % 100 == 0
  return year % 4 == 0
end

def month_days month, leap
  return 31 if [1,3,5,7,8,10,12].include?(month)
  return leap ? 29 : 28 if month == 2
  return 30
end

def year_days year
  return leap_year?(year) ? 366 : 365
end

days_in_year = (1...m).to_a.map { |e| month_days(e, leap_year?(y)) }.sum + d
puts days_in_year
