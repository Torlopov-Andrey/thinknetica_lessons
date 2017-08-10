require_relative 'lib/model/station'
require_relative 'lib/model/cargo_train'
require_relative 'lib/model/passenger_train'
require_relative 'lib/model/route'
require_relative 'lib/model/carriage'
require_relative 'lib/model/boxcar'
require_relative 'lib/model/station'

require_relative 'lib/controller/station_controller'
require_relative 'lib/controller/train_controller'

# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
#      + Создавать станции 
#      + Создавать поезда 
#      - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#      - Назначать маршрут поезду
#      - Добавлять вагоны к поезду
#      - Отцеплять вагоны от поезда
#      - Перемещать поезд по маршруту вперед и назад
#      - Просматривать список станций и список поездов на станции


module Trainspotting

  @station_controller = StationController.new
  @train_controller = TrainController.new
  @routes = []

  def self.description
    puts '  Trainspotting'
    puts '.'*25
    puts '  Select command: '
    puts '  1. Create station'
    puts '  2. Create train'
    # puts '  3. Create and manage route'
    # puts '  4. Set route to train'
    # puts '  5. Add carriage to train'
    # puts '  6. Remove carriage from train'
    # puts '  7. Move train'
    # puts '  8. Show station list and train list on station'
    puts '  0. Exit'
    print '> '
  end

  def self.execute_command(command)
    controller = nil
    case command
      when 1
        controller = :station
      when 2
        controller = :train
      else
        puts "\n\n\n"
        puts "Unknown command"
        puts "\n\n\n"
    end

    loop do
      break unless controller
      eval "@#{controller.to_s}_controller.description"
      # @station_controller.description
      command = gets.chomp.to_i
      break if command == 0
      eval "@#{controller.to_s}_controller.execute_command(command)"
    end
  end

  def self.start
    system("clear")
    loop do
      description
      command = gets.chomp.to_i
      break if command == 0
      execute_command(command)
    end
  end
end

Trainspotting.start
