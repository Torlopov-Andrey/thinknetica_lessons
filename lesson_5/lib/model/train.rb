require_relative 'route'
require_relative 'station.rb'
require_relative './traincar'
require_relative './../module/owner'
require_relative './../module/instance_counter'

class Train
  include Owner
  include InstanceCounter

  attr_reader :number, :carriages, :speed
  @@train_instances = {}
  
  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @current_station_index = 0
    @type = nil
    @carriage_type = nil
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
    puts "... 1"
    return unless self.route?
    return if @current_station_index == @route.stations.count - 1
    puts "... 2"
    self.speed_up
    update_station :forward
  end

  def move_backward
    return unless self.route?
    if @current_station_index == 0
      return "We are at the first station"
    end

    stop
    speed_up
    update_station :backward
  end

  def current_station
    return unless self.route?
    @route.stations[@current_station_index]
  end

  def prev_station
    return unless self.route?
    if @current_station_index - 1 >= 0
      return @route.stations[@current_station_index - 1] 
    else
      return @route.stations[@current_station_index]
    end
  end

  def next_station
    return unless self.route?
    if @current_station_index + 1 < @route.stations.count
      return @route.stations[@current_station_index + 1] 
    end

    return @route.stations[@current_station_index]
  end

  # Данный метод был приватным, но поскольку он вызывается из публичных методов, то делаем его protected
  def update_station direction
    puts "... 3"
    return unless direction
    @route.stations[@current_station_index].remove_train(self)
    @current_station_index += direction == :forward ? 1 : -1
    puts "... 4"
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

  def print_carriages
    @carriages.each_with_index do |carriage, index|
      puts "#{index+1}. Number: #{carriage.number}"
    end
    puts "List is empty" if @carriages.empty?
  end

  def detail
    carriage_numbs = @carriages.map { |carriage|  carriage.number }.join(', ')
    "N:#{self.number} Type: #{self.class == PassengerTrain ? 'Passenger' : 'Cargp'} Carriage numbers: #{carriage_numbs}"
  end

  def route?
    return @route != nil
  end
end
