module Validation
  def self.included(base)
    base.instance_variable_set(:@validation_hash, {})
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validation_hash

    def validate(name, type, options = {})
      validations = @validation_hash[name.to_sym] || []
      validations << { type => options }
      @validation_hash[name.to_sym] = validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.validation_hash.each do |property, validations|
        instance_var = instance_variable_get("@#{property}")
        validations.each { |hash| send hash.keys.first.to_sym, instance_var, hash.values }
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(*params)
      value = params.first
      raise 'Value is nil!' unless value
      raise 'Value can\'t be blank' if value.is_a?(String) && value.delete(' ').empty? 
      raise 'Collection can\'t be empty' if value.respond_to?(count) && value.count.zero?
    end

    def format(value, options)
      options.each do |format, format_value|
        raise 'Value #{value} has invalid format #{format} #{format_value}' if value !~ format_value
      end
    end

    def type(value, options)
      options.each do |_, class_name|
        raise "Value is not class (#{class_name})" unless value.is_a?(class_name)
      end
    end
  end
end
