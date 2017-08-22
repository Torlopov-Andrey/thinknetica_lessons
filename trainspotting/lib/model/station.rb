require_relative './train/train'
require_relative './../module/instance_counter'
require_relative './../module/validation'
require_relative './../module/accessors'

class Station
  extend Accessors
  include InstanceCounter
  include Validation

  attr_reader :trains

  strong_attr_acessor name: String
  validate :name, :presence
  validate :name, :type, String


  @all_instances = []

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self
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
end
