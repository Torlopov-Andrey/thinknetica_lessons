# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

abc = ("a".."z").to_a
vowels = %w( a e i o u )
result = {}

abc.each_with_index do |letter|
  result[letter] = abc.index(letter) + 1 if vowels.include? letter
end

p result
