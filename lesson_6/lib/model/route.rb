require_relative 'station'
require_relative './../module/validate'

class Route
  include Validate
  attr_reader :stations

  def initialize(start, finish)
    validate!
    @stations = [start, finish]
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    index = @stations.index(station)
    @stations.delete(station) if index != 0 && index != @stations.count - 1
  end

  def print_stations
    @stations.each_with_index do |station, index|
      puts "  #{index + 1}. Station: #{station.name}  train count: #{station.trains.count}"
    end
  end

  private

   def validate!
    unless @stations.all? { |station| station.is_a?(Station) }
      raise "Array contains not station object!"
    end
  end
end
