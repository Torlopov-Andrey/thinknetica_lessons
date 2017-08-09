class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(name)
    @stations.insert(-2, name.capitalize) unless @stations.include?(name.capitalize)
  end

  def remove_station(name)
    @stations.delete(name.capitalize) if @stations.index(name.capitalize) != 0 && @stations.index(name.capitalize) != @stations.count - 1
  end
end