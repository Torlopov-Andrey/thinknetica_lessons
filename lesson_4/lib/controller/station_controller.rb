require_relative './../model/station'
require_relative 'controller'

module Trainspotting 
  class StationController < Controller

    def description
      puts
      puts @data.count == 0 ? '1. Add station?' : '1. Add another station'
      puts '2. Show station list' if @data.count > 0
      puts '3. Remove station'    if @data.count > 0
      puts '0. Back'
      print '> '
    end

    def execute_command(command)
      case command
      when 1
        self.add_station
      when 2
        self.show_stations
      when 3 
        self.remove_station
      end
    end

    protected 

    def show_stations
      puts
      @data.each_with_index do |station,index|
        puts "#{index}. Station: #{station.name} :: train count: #{station.trains.count}"
      end
    end

    def add_station
      system("clear")
      puts
      puts 'Input station name'
      print '> '
      name = gets.chomp
      return if @data.select {|station| station.name == name}.count > 0
      @data << Station.new(name) unless name.empty?
    end

    def remove_station
      system("clear")
      self.show_stations
      puts 'Type station index to delete:'
      print '> '
      i = gets.chomp.to_i
      @data.delete_at(i)
    end
  end
end
