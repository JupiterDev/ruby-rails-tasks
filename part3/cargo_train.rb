class CargoTrain < Train
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = []
    @current_speed = 0
  end

  def add_car(car)
    super(car) if car.class == CargoCar
  end

end
