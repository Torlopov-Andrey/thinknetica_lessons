
 # Программа запрашивает у пользователя имя и рост и выводит идеальный
 # вес по формуле <рост> - 110, после чего выводит результат пользователю
 # на экран с обращением по имени. Если идеальный вес получается отрицательным,
 # то выводится строка "Ваш вес уже оптимальный"

def perfect_weight name, height
  perfect_weight = height - 110
  result =  if perfect_weight >=0
              "#{name} your optimal weight #{perfect_weight}."
            else
              '#{name} you already have optimal weight.'
            end
  result
end

print 'Input name: '
name = gets.chomp.capitalize!
print 'Input height: '
height = gets.chomp.to_i

p perfect_weight name, height
