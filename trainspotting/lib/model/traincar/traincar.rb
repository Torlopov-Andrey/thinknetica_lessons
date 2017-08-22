require_relative './../../module/owner'
require_relative './../../module/instance_counter'
require_relative './../../module/validation'

class TrainCar
  include Owner
  include InstanceCounter
  include Validation

  attr_reader :number
  
  NUMBER_FORMAT = /^[а-я\d]{3}-?[а-я\d]{2}/i

  def initialize(number)
    @number = number
    validate!(:number, :format, format: NUMBER_FORMAT)
  end
end
