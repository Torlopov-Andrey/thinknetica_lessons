module Trainspotting
  
  class Route
    def initialize start, finish
      @stations = { start: start, finish: finish, intermediate: [] }
      @current_station_index = 0
    end

    def add_station name
      @stations[:intermediate] << name.capitalize unless @stations[:intermediate].include?(name.capitalize)
    end

    def remove_station name
      @stations[:intermediate].delete(name.capitalize)
    end

    def station_list
      [@stations[:start]] + @stations[:intermediate] + [@stations[:finish]]
    end

    def reset_current_station
      @current_station = @stations[:start]
    end

    def next
      @current_station_index += 1 if @current_station_index < station_list.count - 1
    end

    def prev
      @current_station_index -= 1 if @current_station_index > 0
    end

    def current_station
      return self.station_list[@current_station_index]
    end
  end
end