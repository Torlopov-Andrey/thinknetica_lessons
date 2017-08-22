require_relative 'train'
require_relative './../traincar/boxcar'

class CargoTrain < Train
  def initialize(number)
    super(number)
    @type = CargoTrain
    @carriage_type = BoxCar
  end
end
