module Validate
    NUMBER_FORMAT = /^[а-я\d]{3}-?[а-я\d]{2}/i
    
    def validate!
      if self.respond_to?(:number) 
        raise "Number can't be nil" if self.number.nil? 
        raise "Number should be at least 5 symbols" if self.number.to_s.length < 5
        raise "Number has invalid formar" if number !~ NUMBER_FORMAT
      end

      if self.respond_to?(:name)
        raise "Name can't be nil" if self.name.nil? 
        raise "Name should be at least 5 symbols" if self.name.length < 5
      end
      true
    end

    def valid?
      validate!
      true
    rescue
      false
    end
end
