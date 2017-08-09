require_relative 'route'
require_relative 'station.rb'

class Train
  attr_reader :number, :type, :carriage_count, :speed
  
  def initialize(number, type, carriage_count)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
    @current_station_index = 0
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def add_carriage
    @carriage_count += 1 if @speed == 0
  end

  def remove_carriage
    @carriage_count -= 1 if @speed == 0
  end

  def route=(route)
    @route = route
    @current_station_index = 0
  end

  def move_forward
    puts "move forward"
    if @current_station_index == @route.stations.count - 1
      return
    end
    
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

  private 

  def update_station direction
    return unless direction
    @route.stations[@current_station_index].remove_train(self)
    @current_station_index += direction == :forward ? 1 : -1
    @route.stations[@current_station_index].add_train(self)
  end
end
