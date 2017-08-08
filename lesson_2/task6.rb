# Пользователь вводит поочередно название товара, цену за единицу
# и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор,
# пока не введет "стоп" в качестве названия товара. На основе введенных
# данных требуетеся:
# - Заполнить и вывести на экран хеш, ключами которого являются названия
# товаров, а значением - вложенный хеш, содержащий цену за единицу товара
# и кол-во купленного товара.
# - Также вывести итоговую сумму за каждый товар.
# - Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

module OrderPurchases
  @products = {}

  def self.input_data
    puts
    puts "."*60
    puts "Input procudt name, price per item and value."
    puts "If you're finish, type 'stop'\n"
    puts "."*60
    puts

    loop do
      print "Input product name: "
      product = gets.chomp
      break if product.upcase == 'STOP'

      print "Input price per item: "
      price = gets.chomp.to_f

      print "Input value: "
      value = gets.chomp.to_f

      process_data product.downcase.to_sym, price, value
    end
  end

  def self.process_data product, price, value
    data = @products[product] == nil ? {} : @products[product]
    data[price] = value
    @products[product] = data
  end

  def self.products
    @products
  end

  def self.check
    check = @products.map do |k,v|
      value_sum = v.map { |k1, v1| k1 * v1 }.sum
      {k => value_sum }
    end
    check
  end

  def self.total_sum
    check.map { |e| e.values.sum }.sum
  end
end

puts OrderPurchases.input_data
puts '.'*30 +  'product info'  + '.' * 30
puts OrderPurchases.products
puts '.'*30 + 'products costs'  + '.' * 30
puts OrderPurchases.check
puts '.'*30 +  'total sum'  + '.' * 30
puts OrderPurchases.total_sum
