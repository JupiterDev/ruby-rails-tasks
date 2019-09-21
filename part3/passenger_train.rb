class PassengerTrain < Train
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = []
    @current_speed = 0
  end

  def add_car(car)
    super(car) if car.class == PassengerCar
  end

end
