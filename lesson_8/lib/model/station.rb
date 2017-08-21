require_relative './train/train'
require_relative './../module/instance_counter'
require_relative './../module/validate'

class Station
  include InstanceCounter
  include Validate

  attr_reader :name, :trains

  @all_instances = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @all_instances << self
    register_instance
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

  def self.all
    @all_instances
  end

  def each_train(&block)
    return unless block
    @trains.each { |train| yield(train) }
  end

  private

  def validate!
    raise "Name can't be nil" if name.nil?
    raise 'Name should be at least 5 symbols' if name.length < 5
  end
end
