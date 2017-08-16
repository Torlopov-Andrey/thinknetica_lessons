module Trainspotting
  class Controller
    attr_reader :data, :type

    def initialize
      @data = []
    end

    def description
      puts
      puts @data.count == 0 ? "1. Add #{@type}" : "1. Add another #{@type}"
      puts "2. Show #{@type} list"
      puts "3. Remove #{@type}"
      puts '0. Back'
      print '> '
    end

    def execute_command(command)
      case command
      when 1
        self.add
      when 2
        self.show
      when 3 
        self.remove
      end
    end
  end
end
