class CargoTrain < Train
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = {}
  end

  def add_car(car)
    @cars[car] = CargoCar.new
  end

  def remove_car(car)
		@cars.delete(car)
	end
end