require_relative './../model/station'
require_relative 'controller'

module Trainspotting
  class StationController < Controller
    def initialize
      super
      @type = 'station'
    end

    protected

    def show
      puts
      @data.each_with_index do |station, index|
        puts "#{index + 1}. Station: #{station.name} :: train count: #{station.trains.count}\n\n"
        station.each_train do |train|
          puts "№: #{train.number} #{train.class} carriage count: #{train.carriages.count}"
        end
      end
      puts "\n\nStation list is empty" if @data.empty?
    end

    def add
      system('clear')
      puts
      puts 'Input station name'
      print '> '
      name = gets.chomp
      return if @data.select { |station| station.name == name }.count > 0
      @data << Station.new(name) unless name.empty?
    end

    def remove
      system('clear')
      show
      puts 'Type station index to delete:'
      print '> '
      i = gets.chomp.to_i
      @data.delete_at(i)
    end
  end
end
