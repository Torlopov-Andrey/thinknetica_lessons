require_relative './../model/passenger_train'
require_relative './../model/cargo_train'
require_relative 'controller'

module Trainspotting 
  class TrainController < Controller
      def description
      puts
      puts @data.count == 0 ? '1. Add train?' : '1. Add another train'
      puts '2. Show train list' if @data.count > 0
      puts '3. Remove train'    if @data.count > 0
      puts '0. Back'
      print '> '
    end

    def execute_command(command)
      case command
      when 1
        self.add_train
      when 2
        self.show_trains
      when 3 
        self.remove_train
      end
    end

    protected 

    def show_trains
      puts
      @data.each_with_index do |train, index|
        puts "#{index}. Train. N:#{train.number} Type:#{train.class == PassengerTrain ? 'Passenger' : 'Cargo'}"
      end
    end

    def add_train
      system("clear")
      puts
      puts 'Input train number and type (1 - carriage, 2 - boxcar)'
      puts 'Example: 123 1'
      print '> '
      numb_type_arr = gets.chomp.split(" ")      
      numb = numb_type_arr[0].to_i
      type = numb_type_arr[1].to_i
      return if @data.select {|train| train.number == numb}.count > 0
      train = nil
      if type == 1 
        train = PassengerTrain.new(numb)
      elsif type == 2
        train = CargoTrain.new(numb)
      else
        return
      end
      @data << train
    end

    def remove_train
      system("clear")
      self.show_trains
      puts 'Type train index to delete:'
      print '> '
      i = gets.chomp.to_i
      @data.delete_at(i)
    end
  end
end
