require_relative 'route.rb'

module Trainspotting
  
  class Train
    attr_reader :uid, :type, :carriage_count, :speed
    def initialize uid, type, carriage_count
      @uid = uid
      @type = type
      @carriage_count = carriage_count
      @speed = 0
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

    def set_route route
      @route = route
      @route.reset_current_station
    end

    def move_forward
      @route.next
    end

    def move_backward
      @route.prev
    end
    
    def current_station
      @route.current_station
    end
  end
end