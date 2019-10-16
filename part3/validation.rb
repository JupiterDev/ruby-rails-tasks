module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

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
        send("validate_#{item[:type]}", instance_variable_get("@#{item[:name]}"), *item[:params])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    def validate_presence(var)
      raise "Ошибка! Значение пустое или равно nil." if var.nil? || var.empty?
    end

    def validate_format(var, format)
      raise "Ошибка! Неверный формат." unless var =~ format
    end

    def validate_type(var, type)
      raise "Ошибка! Неверный тип." unless var.instance_of? type
    end
  end
end
