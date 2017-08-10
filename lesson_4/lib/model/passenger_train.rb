require_relative 'train'
require_relative 'carriage'

class PassengerTrain < Train
  def add_carriage(carriage)
    super
    unless carriage.class == Carriage
      puts "Need only Carriage!"
      return  
    end
    return if @carriages.include?(carriage)

    @carriages << carriage
  end

  def remove_carriage(carriage)
    super
    @carriages.delete(carriage)
  end
end
