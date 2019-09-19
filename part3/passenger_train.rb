class PassengerTrain < Train
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = []
  end

  # def add_car(car)
  #   super if car.class == PassengerCar
  # end

  # def remove_car(car)
  #   @cars.delete(car)
  # end
end
