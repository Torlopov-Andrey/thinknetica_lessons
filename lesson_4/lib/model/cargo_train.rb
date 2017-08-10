require_relative 'train'
require_relative 'boxcar'

class CargoTrain < Train
   def add_carriage(carriage)
    super
    unless carriage.class == BoxCar
      puts "Need only CarriageCar!"
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
