require_relative './../model/passenger_train'
require_relative './../model/cargo_train'
require_relative 'controller'

module Trainspotting 
  class TrainController < Controller

    def initialize
      super
      @type = 'train'
    end

    def show
      puts 
      @data.each_with_index do |train, index|
        puts "#{index + 1}. #{train.detail}"
      end
      puts "List is empty" if @data.empty?
      puts
    end

    protected 

    def add
      system("clear")
      puts
      puts 'Input train number and type (1 - carriage, 2 - boxcar)'
      puts 'Example: 33 1'
      print '> '
      numb_type_arr = gets.chomp.split(" ")      
      numb = numb_type_arr[0].to_i
      type = numb_type_arr[1].to_i
      return if @data.select {|train| train.number == numb}.count > 0
      if type == 1 
        train = PassengerTrain.new(numb)
      elsif type == 2
        train = CargoTrain.new(numb)
      else
        return
      end
      @data << train
    end

    def remove
      system("clear")
      self.show
      puts 'Type train index to delete:'
      print '> '
      i = gets.chomp.to_i
      @data.delete_at(i)
    end
  end
end
