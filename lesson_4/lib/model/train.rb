require_relative 'route'
require_relative 'station.rb'

class Train
  attr_reader :number, :carriages, :speed
  
  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @current_station_index = 0
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
  end

  def move_forward
    return if @current_station_index == @route.stations.count - 1
    self.speed_up
    update_station :forward
  end

  def move_backward
    if @current_station_index == 0
      puts "We are at the first station"
      return
    end
    
    stop
    speed_up
    update_station :backward
  end
  
  def current_station
    @route.stations[@current_station_index]
  end

  def prev_station
    return @route.stations[@current_station_index - 1] if @current_station_index - 1 >= 0
    puts "You are at the first station"
    return @route.stations[@current_station_index]
  end

  def next_station
    return @route.stations[@current_station_index + 1] if @current_station_index + 1 < @route.stations.count
    puts "You are at the last station"
    return @route.stations[@current_station_index]
  end

  protected

  # Данный метод был приватным, но поскольку он вызывается из публичных методов, то делаем его protected
  def update_station direction
    return if direction == nil
    @route.stations[@current_station_index].remove_train(self)
    @current_station_index += direction == :forward ? 1 : -1
    @route.stations[@current_station_index].add_train(self)
  end

  # Данные методы будут переопределяться в наследниках
  def add_carriage(carriage)
    if @speed > 0 
      puts "Can't add carriage, cause carriage still moving."
      return
    end
  end

  # Данные методы будут переопределяться в наследниках
  def remove_carriage(carriage) 
    if @speed > 0 
      puts "Can't remove carriage, cause carriage still moving."
      return
    end
  end
end
