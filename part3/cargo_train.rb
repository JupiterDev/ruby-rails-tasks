class CargoTrain < Train
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = []
  end

  # def add_car(car)
  #   super if car.class == CargoCar
  # end

  # def remove_car(car)
  #   @cars.delete(car)
  # end
end
