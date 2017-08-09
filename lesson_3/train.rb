require_relative 'route'

class Train
  attr_reader :number, :type, :carriage_count, :speed
  
  def initialize(number, type, carriage_count)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
    @current_statin_index = 0
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

  def set_route(route)
    @route = route
    @current_statin_index
  end

  def move_forward
    if @current_station_index == station_list.count - 1
      puts "We are at the terminal station"
      return
    end

    @current_station_index += 1 
  end

  def move_backward
    if @current_station_index == 0
      puts "We are at the first station"
      return
    end

    @current_station_index -= 1
  end
  
  def current_station
    @route.stations[@current_statin_index]
  end
end