require_relative './../model/route'
require_relative './controller'
require_relative './station_controller'
require_relative './../model/route'

module Trainspotting
  class RouteController < Controller
    attr_reader :station_controller

    def initialize
      super
      @type = 'route'
    end

    attr_writer :station_controller

    def show
      @data.each_with_index do |route, index|
        puts "#{index + 1}. #{@type}: "
        route.print_stations
        puts '.' * 25
      end
      puts 'List is empty' if @data.empty?
    end

    protected

    def add
      system('clear')
      stations = []
      loop do
        print_add_description(stations)
        print '> '
        command = gets.chomp.to_i
        break if command.zero?
        execute_command(command)        
      end
    end

    def remove
      system('clear')
      show
      puts 'Type station index to delete:'
      print '> '
      i = gets.chomp.to_i - 1
      @data.delete_at(i)
    end

    private

    def edit_station_list
      loop do
        @station_controller.description
        command = gets.chomp.to_i
        break if command.zero?
        @station_controller.execute_command(command)
      end
    end

    def print_add_description(stations)
      messages = { 0 => 'Require first station', 1 => 'Require last station' }
      puts messages[stations.count] || 'You can add some stations'
      puts '\n\n1. Select station from station list\n2. Edit station list'
      puts '3. Save route' if stations.count >= 2
      puts '0. Back'
      print '> '
    end

    def select_station_index(stations)
      puts 'Select index of station'
      @station_controller.execute_command(2)
      print '> '
      index = gets.chomp.to_i
      station = @station_controller.data[index - 1]
      return nil if !stations || stations.include?(station)
      station
    end

    def execute_command(command)
      case command
      when 1
        stations << select_station_index(stations)
      when 2
        edit_station_list
      when 3
        @data << Route.new(stations.shift, stations.shift)
        stations.each { |station| @data.last.add_station(station) }
      end
    end
  end
end
