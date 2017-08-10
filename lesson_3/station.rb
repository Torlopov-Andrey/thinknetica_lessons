require_relative 'train'

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
    puts "."*20 + "add" + "."*20
    p train_list
    p train_list :passenger
  end

  def remove_train(train)
    @trains.delete(train)
    puts "."*20 + "remove" + "."*20
    p train_list
    p train_list :passenger
  end

  def train_list(train_type = :goods)
    @trains.select { |train| train.type == train_type }
  end
end

