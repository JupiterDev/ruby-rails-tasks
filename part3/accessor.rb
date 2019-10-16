module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_history = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}_history".to_sym) { instance_variable_get(var_history) }

      define_method("#{name}=".to_sym) do |value|
        if instance_variable_get(var_history).nil?
          instance_variable_set(var_history, [])
        else
          instance_variable_get(var_history) << (instance_variable_get(var_name))
        end
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(name_attr, class_attr)
    define_method(name_attr) do
      instance_variable_get("@#{name_attr}")
    end

    define_method("#{name_attr}=") do |value|
      if value.instance_of? class_attr
        instance_variable_set("@#{name_attr}", value)
      else
        raise "Неверный тип."
      end
    end
  end
end
