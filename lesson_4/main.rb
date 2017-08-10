require_relative 'lib/model/station'
require_relative 'lib/model/cargo_train'
require_relative 'lib/model/passenger_train'
require_relative 'lib/model/route'
require_relative 'lib/model/carroage'
require_relative 'lib/model/boxcar'
require_relative 'lib/model/station'


t = PassengerTrain.new(1)
c = CarriageCar.new(11)
t.add_carriage(c)
t.add_carriage(c)
puts t.carriages
