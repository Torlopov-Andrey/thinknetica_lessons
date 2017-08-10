require_relative 'station'

class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    index = @stations.index(station)
    @stations.delete(station) if index != 0 && index != @stations.count - 1
  end
end
