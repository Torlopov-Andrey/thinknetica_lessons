require_relative 'lib/model/station'
require_relative './lib/model/train/cargo_train'
require_relative './lib/model/train/passenger_train'
require_relative './lib/model/route'
require_relative './lib/model/traincar/carriage'
require_relative './lib/model/traincar/boxcar'
require_relative './lib/model/station'
require_relative './lib/controller/station_controller'
require_relative './lib/controller/train_controller'
require_relative './lib/controller/route_controller'

module Trainspotting
  @station_controller = StationController.new
  @train_controller = TrainController.new
  @route_controller = RouteController.new

  def self.start
    system('clear')
    @route_controller.station_controller = @station_controller
    loop do
      description
      command = gets.chomp.to_i
      break if command == 0
      execute_command(command)
    end
  end

  def self.description
    puts '  Trainspotting'
    puts '.' * 25
    puts '  Select command: '
    puts '  1. Create station'
    puts '  2. Create train'
    puts '  3. Create and manage route'
    puts '  4. Set route to train'
    puts '  5. Add carriage to train'
    puts '  6. Remove carriage from train'
    puts '  7. Move train throught route'
    puts '  8. Take place or load volume in trainbox'
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
    when 3
      controller = :route
    when 4
      set_route_to_train
      return
    when 5
      add_carrieage_to_train
      return
    when 6
      remove_carriage_from_train
      return
    when 7
      move_train_in_route
      return
    when 8
      take_place_or_load_volume
    else
      puts "\n"
      puts '>>>>>  Unknown command'
      puts "\n"
    end

    loop do
      break unless controller
      eval "@#{controller}_controller.description"
      command = gets.chomp.to_i
      break if command == 0
      eval "@#{controller}_controller.execute_command(command)"
    end
  end

  def self.set_route_to_train
    loop do
      puts '1. Set route to train'
      puts
      puts 'Select train index'
      @train_controller.show
      print '> '
      train_index = gets.chomp.to_i - 1
      puts '2. Select route index'
      @route_controller.show
      print '> '
      route_index = gets.chomp.to_i - 1

      if @train_controller.data[train_index] &&
         @route_controller.data[route_index]
        @train_controller.data[train_index].route = @route_controller.data[route_index]
      end

      puts
      puts 'Set route to train? (Y/n) '
      print '> '
      answer = gets.chomp
      break if answer.casecmp('N').zero?
    end
  end

  def self.add_carrieage_to_train
    loop do
      puts 'Add carriage to train'
      puts 'Select train index: '
      print '> '
      @train_controller.show
      train_index = gets.chomp.to_i - 1
      train = @train_controller.data[train_index]
      if train
        puts 'Input carriage number: '
        print '> '
        number = gets.chomp
        className = train.class == PassengerTrain ? 'Carriage' : 'BoxCar'
        puts "Input #{className == 'Carriage' ? 'places' : 'volume'}:"
        print '> '
        places_volume = gets.chomp.to_i
        puts "debug: #{number}"
        train.add_carriage(Trainspotting.const_get(className).new(number, places_volume))

        train.each_carriage do |carriage|
          value = if carriage.is_a?(Carriage)
                    "taked places: #{carriage.taked_places} free: #{carriage.avaliable_places}"
                  else
                    "loaded volume: #{carriage.loaded_volume} free: #{carriage.avaliable_volume}"
                  end
          puts "N:#{carriage.number}, #{carriage.class}, #{value}"
        end
      end
      break unless train
      puts
      puts 'Add another carriage? (Y/n)'
      print '> '
      answer = gets.chomp.upcase
      break if answer == 'N'
    end
  end

  def self.remove_carriage_from_train
    loop do
      puts 'Select train, where you want delete carriage'
      @train_controller.show
      print '> '
      train_index = gets.chomp.to_i - 1
      train = @train_controller.data[train_index]
      next unless train
      puts 'Select carriage which you want delete\n\n'
      train.print_carriages
      print '> '
      carriage_index = gets.chomp.to_i - 1
      if train.carriages[carriage_index]
        train.remove_carriage(train.carriages[carriage_index])
      end
      break train.carriages.empty?
      puts '\nRemove another carriage? (Y/n)'
      print '> '
      answer = gets.chomp.upcase
      break if answer == 'N'
    end
  end

  def self.move_train_in_route
    if @train_controller.data.count == 0
      puts 'List is empty'
      return
    end

    system('clear')
    loop do
      puts 'Pick train in list and select direction'
      puts @train_controller.show
      puts 'Pick train: '
      print '> '
      train_index = gets.chomp.to_i - 1
      train = @train_controller.data[train_index]
      next unless train
      puts '1. Move forward'
      puts '2. Move backward'
      puts '0. Back'
      print '> '
      command = gets.chomp.to_i
      break if command == 0
      case command
      when 1
        suffix = 'forward'
      when 2
        suffix = 'backward'
      else
        puts 'Unknown command'
        break
      end
      eval "@train_controller.data[train_index].move_#{suffix}"
      puts "Current station: #{train.current_station.name}"
    end
  end

  def self.take_place_or_load_volume
    puts 'Select train: '
    @train_controller.show
    print '> '
    train_index = gets.chomp.to_i - 1
    train = @train_controller.data[train_index]
    return unless train
    train.each_carriage do |carriage|
      value = if carriage.is_a?(Carriage)
                "taked places: #{carriage.taked_places} free: #{carriage.avaliable_places}"
              else
                "loaded volume: #{carriage.loaded_volume} free: #{carriage.avaliable_volume}"
              end
      puts "N:#{carriage.number}, #{carriage.class}, #{value}"
    end

    puts
    puts "Select carriage #{train.class == PassengerTrain ? ', and set value' : ''}: "
    print '> '
    index_value_ary = gets.chomp.split(' ')
    index = index_value_ary[0].to_i
    value = index_value_ary[1].to_i if train.class == CargoTrain
    if train.class == PassengerTrain
      train.carriages[index].take_place!
    else
      train.carriages[index].load(value)
    end
  end
end

Trainspotting.start
