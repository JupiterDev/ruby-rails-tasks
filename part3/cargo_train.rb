class CargoTrain < Train
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = []
  end

  def add_car
    @cars << CargoCar.new
  end

  def remove_car
		@cars.shift
	end
end