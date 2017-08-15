module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def instances
      @instances
    end
    
    private

    def instances=(instances)
      @instances = instances
    end
  end

  module InstanceMethods
    def register_instance
      self.class.send :instances=, self.class.instances ? self.class.instances + 1 : 1
    end
  end
end
