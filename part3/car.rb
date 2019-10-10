class Car
  include Company
  
  # метод, возвращающий кол-во доступных мест/объем
  attr_reader :available_units

  def initialize(units)
    @default_units = units      # общее кол-во мест / общий объем
    @available_units = units    # доступное кол-во мест / общий объем
  end

  #  метод, который возвращает кол-во занятых мест / занятый объем
  def occupied_units
    @default_units - @available_units
  end
end
