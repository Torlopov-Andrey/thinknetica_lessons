module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = 0
    def instances
      @@instances
    end
    
    private

    def inc_instances
      @@instances += 1
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.send :inc_instances
    end
  end
end
