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

    def station_controller=(station_controller)
      @station_controller = station_controller
    end

    def show
      @data.each_with_index do |route,index|        
        puts "#{index+1}. #{@type}: "
        route.print_stations
        puts "."*25
      end
      puts "List is empty" if @data.empty?
    end

    protected 

    def add
      system("clear")
      stations = []
      loop do
        case stations.count
        when 0
          puts "Require first station"
        when 1
          puts "Require last station"
        else 
          puts "You can add some stations"
        end
        puts
        puts "1. Select station from station list"
        puts "2. Edit station list"
        puts "3. Save route" if stations.count >= 2
        puts "0. Back"
        print '> '
        command = gets.chomp.to_i
        break if command == 0

        case command
        when 1
          puts "Select index of station"
          @station_controller.execute_command(2)
          print '> '
          index = gets.chomp.to_i
          station = @station_controller.data[index-1]
          if station && !stations.include?(station)
            stations << station  
          end
        when 2 
          edit_station_list
        when 3
          route = Route.new(stations.shift, stations.shift)
          stations.each { |s| route.add_station(s) }
          @data << route
          break
        end
      end
    end

    def remove
      system("clear")
      self.show
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
        break if command == 0
        @station_controller.execute_command(command)
      end
    end
  end
end
