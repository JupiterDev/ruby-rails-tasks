class CargoTrain < Train
  attr_reader :cars
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = {}
  end

  def add_car(car, car_number)
    @cars[car_number] = car
  end

  def remove_car(car)
    @cars.delete(car)
  end
end