require_relative './../route'
require_relative './../station.rb'
require_relative './../traincar/traincar'
require_relative './../../module/owner'
require_relative './../../module/instance_counter'
require_relative './../../module/validate'
require_relative './../../module/validate_number'

class Train
  include Owner
  include InstanceCounter
  include Validate
  include ValidateNumber

  attr_reader :number, :speed, :carriages
  @@train_instances = {}
  
  def initialize(number)
    @number = number
    validate!
    @carriages = []
    @speed = 0
    @current_station_index = 0
    @@train_instances[number] = self
  end
  
  def self.find(number)
    @@train_instances[number]
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def route=(route)
    @route = route    
    @current_station_index = 0
    @route.stations[@current_station_index].add_train(self)
  end

  def move_forward
    return unless route?
    return if @current_station_index == @route.stations.count - 1
    speed_up
    update_station :forward
  end

  def move_backward
    return unless route?
    if @current_station_index == 0
      return "We are at the first station"
    end

    stop
    speed_up
    update_station :backward
  end

  def current_station
    return unless route?
    @route.stations[@current_station_index]
  end

  def prev_station
    return unless route?
    if @current_station_index - 1 >= 0
      return @route.stations[@current_station_index - 1] 
    else
      return @route.stations[@current_station_index]
    end
  end

  def next_station
    return unless route?
    if @current_station_index + 1 < @route.stations.count
      return @route.stations[@current_station_index + 1] 
    end

    return @route.stations[@current_station_index]
  end

  # Данный метод был приватным, но поскольку он вызывается из публичных методов, то делаем его protected
  def update_station direction
    return unless direction
    @route.stations[@current_station_index].remove_train(self)
    @current_station_index += direction == :forward ? 1 : -1
    @route.stations[@current_station_index].add_train(self)
  end
  
  def moving?
    @speed > 0
  end

  def add_carriage(carriage)
    return "Train still moving" if moving? 

    unless carriage.class == @carriage_type
      return "Need only Carriage!"
    end

    @carriages << carriage unless @carriages.include?(carriage)
    "Carriage added"
  end

  def remove_carriage(carriage)
    return "Train still moving" if moving? 
    @carriages.delete(carriage)
    "Carriage removed"
  end
  
  def detail
    carriage_numbs = @carriages.map { |carriage|  carriage.number }.join(', ')
    "N:#{number} Type: #{self.class == PassengerTrain ? 'Passenger' : 'Cargp'} Carriage numbers: #{carriage_numbs}"
  end

  def route?
    return @route != nil
  end

  def each_carriage(&block)
    return unless @carriages
    return unless block
    @carriages.each { |carriage| block.call(carriage) }
  end
end
