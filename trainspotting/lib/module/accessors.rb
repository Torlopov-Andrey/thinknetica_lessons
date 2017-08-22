module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      define_method("#{method}") do
        instance_variable_get("@#{method}")
      end

      define_method("#{method}=") do |v|
        instance_variable_set("@#{method}_history", []) unless instance_variable_get("@#{method}_history")
        instance_variable_get("@#{method}_history") << v
        instance_variable_set("@#{method}", v)
      end

      define_method("#{method}_history") do
        instance_variable_set("@#{method}_history", []) unless instance_variable_get("@#{method}_history")
        instance_variable_get("@#{method}_history")
      end
    end
  end

  def strong_attr_acessor methods
    methods.each do |method, class_name|
      define_method("#{method}") do
        instance_variable_get("@#{method}")
      end

      define_method("#{method}=") do |v|
        raise TypeError, "Instance #{method} is not instance of #{class_name.to_s}" unless v.is_a?(class_name)
        instance_variable_set("@#{method}", v)
      end
    end
  end
end
