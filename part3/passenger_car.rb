class PassengerCar < Car
  # метод, который возвращает кол-во занятых мест в вагоне
  # метод, возвращающий кол-во свободных мест в вагоне
  attr_reader :occupied_units, :units

  def initialize(units)
    # атрибут общего кол-ва мест
    @units = units
    @occupied_units = 0
  end
  
  # метод, который "занимает места" в вагоне
  def take_a_unit
    @units -= 1 if @units > 0
    @occupied_units += 1 if @units > 0
  end

end
