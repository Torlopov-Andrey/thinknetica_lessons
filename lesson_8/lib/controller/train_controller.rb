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
      puts 'List is empty' if @data.empty?
      puts
    end

    protected

    def add
      attempt = 0
      system('clear')
      begin
        numb, type = input_add_params
        return unless check_data_and_type(@data, numb, type)
        train = type == 1 ? PassengerTrain.new(numb) : CargoTrain.new(numb)
      rescue RuntimeError => e
        attempt += 1
        puts "Can't create train!\nException: #{e.inspect}\n\n"
        attempt < 10 ? retry : return
      end
      puts "Created train:\n#{train.detail}\n\n"
      @data << train
    end

    def remove
      system('clear')
      show
      puts 'Type train index to delete:'
      print '> '
      i = gets.chomp.to_i
      @data.delete_at(i)
    end

    private

    def input_add_params
      puts '\nInput train number(АБЦ-123) and type (1 - carriage, 2 - boxcar)\n\nExample: фыв-йцу 1'
      print '> '
      numb_type_arr = gets.chomp.split(' ')
      [numb_type_arr[0], numb_type_arr[1].to_i]
    end

    def check_data_and_type(data, number, type)
      data.select { |train| train.number == number }.count.zero? || (type != 1 && type != 2)
    end
  end
end
