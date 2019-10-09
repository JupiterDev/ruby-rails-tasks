class CargoCar < Car
  # метод, который возвращает занятый объем
  # метод, который возвращает оставшийся (доступный) объем
  attr_reader :occupied_units, :units

	def initialize(units)
		# атрибут общего объема
		@units = units
		@occupied_units = 0
  end
  
  # метод, которые "занимает объем" в вагоне
  def take_a_unit
    @units -= 1 if @units > 0
    @occupied_units += 1 if @units > 0
  end
end
