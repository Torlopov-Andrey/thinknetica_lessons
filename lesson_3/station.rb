require_relative 'train.rb'
require_relative 'route.rb'

module Trainspotting

  class Station
    attr_reader :name

    def initialize name
      @name = name
      @trains = []
    end

    def take train
      @trains << train
    end

    def release train
      @trains.delete(train) if @trains.include?(train)
    end

    def trains_list
      @trains
    end

    def train_list_with_type
      result = {}

      @trains.each do |train|
        if result[train.type] == nil
          result[train.type] = [train]
        else
          result[train.type] << train
        end
      end

      result
    end
  end
end