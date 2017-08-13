require_relative './../module/owner'
require_relative './../module/instance_counter'

class TrainCar
  include Owner
  include InstanceCounter
  
  attr_reader :number

  def initialize(number)
    @number = number
  end
end

