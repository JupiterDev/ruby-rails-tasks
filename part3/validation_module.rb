module Validation

  module ClassMethods
    attr_reader :validation
    
    def validate(name, type, *params)
      @validation ||= []
      @validation << {name: name, type: type, params: params}
    end
  end

  module InstanceMethods
    def validate!
      self.class.validation.each do |item|
        send("validate_#{item[:type]}", item[:name], item[:params])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    def validate_presence(name, params)
      raise "Ошибка! #{name} пустое или равно nil." if name.blank?
    end

    def validate_format(name, params)
      raise "Ошибка! Неверный формат." unless name =~ params
    end

    def validate_type(name, params)
      raise "Ошибка! Неверный тип." unless name.instance_of? params
    end
  end
end
