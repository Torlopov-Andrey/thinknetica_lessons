require_relative 'train'
require_relative 'route'

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def remove_train(train)
    @trains.delete(train)
  end

  def train_list(train_type = :goods)
    @trains.select { |train| train.type == train_type }
  end
end

# s = Station.new "123123"
# t = Train.new 1, :goods, 3
# t1 = Train.new 2, :goods, 4
# t2 = Train.new 2, :passenger, 5

# s.add_train t
# s.add_train t1
# s.add_train t2
# puts s.train_list :passenger
