require_relative 'traincar'

class Carriage < TrainCar
  attr_reader :max_places, :taked_places

  def initialize(number, max_places)
    super(number)
    @max_places = max_places
    @taked_places = 0
  end

  def take_place!
    raise "No free places!" if @taked_places == @max_places
    @taked_places += 1
  end

  def release_place
    return if @taked_places == 0
    @taked_places -= 1
  end

  def avaliable_places
    @max_places - @taked_places
  end
end
