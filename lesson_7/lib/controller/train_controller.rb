require_relative './../model/train/passenger_train'
require_relative './../model/train/cargo_train'
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
      attempt = 0
      system("clear")
      begin
        puts
        puts 'Input train number(АБЦ-123) and type (1 - carriage, 2 - boxcar)'
        puts 'Example: фыв-йцу 1'
        print '> '
        numb_type_arr = gets.chomp.split(" ")
        numb = numb_type_arr[0]
        type = numb_type_arr[1].to_i
        return if @data.select {|train| train.number == numb}.count > 0
        
        if type == 1 
          train = PassengerTrain.new(numb)
        elsif type == 2
          train = CargoTrain.new(numb)
        else
          return
        end
      rescue RuntimeError => e
        attempt += 1
        if attempt == 10
          puts "Do you want continue?(Y/n)"
          print '> '
          answer = gets.chomp.upcase
          attempt = 0
          return if answer == 'N'
        end
        puts "Can't create train! "
        puts "Exception: #{e.inspect}"
        puts 
        retry if attempt < 10
      end
      puts "Created train:\n#{train.detail}\n\n"      

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
