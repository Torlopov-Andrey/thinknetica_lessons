require_relative './../../module/owner'
require_relative './../../module/instance_counter'
require_relative './../../module/validate'
require_relative './../../module/validate_number'

class TrainCar
  include Owner
  include InstanceCounter
  include Validate
  include ValidateNumber

  attr_reader :number

  def initialize(number)
    @number = number
    validate!
  end
end

