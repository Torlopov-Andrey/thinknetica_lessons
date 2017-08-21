require_relative './traincar'

class BoxCar < TrainCar
  attr_reader :max_volume, :loaded_volume

  def initialize(number, max_volume)
    super(number)
    @max_volume = max_volume
    @loaded_volume = 0
  end

  def load(volume)
    if @loaded_volume + volume > @max_volume
      raise "Overload! max volume: #{@max_volume} loaded volume: #{@loaded_volume}"
    end
    @loaded_volume += volume
  end

  def unload(volume)
    @loaded_volume =  @loaded_volume - volume < 0 ? 0 : @loaded_volume - volume
  end

  def avaliable_volume
    @max_volume - @loaded_volume
  end
end
