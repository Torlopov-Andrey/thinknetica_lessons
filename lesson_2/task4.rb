# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

abc = ("a".."z").to_a
vowels = ["a","e","i","o","u","y"]
result = {}
abc.inject({}) do |r,e|
  if vowels.include? e
    result[e] = abc.index(e) + 1
  end
end

p result
