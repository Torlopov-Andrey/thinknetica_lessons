require_relative 'train'
require_relative 'carriage'

class PassengerTrain < Train
  def initialize(number)
    super(number)
    @type = PassengerTrain
    @carriage_type = Carriage
  end
end
