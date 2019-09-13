class PassengerTrain < Train
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = {}
  end
    
  def add_car(car)
    @cars[car] = PassengerCar.new
  end
    
  def remove_car(car)
    @cars.delete(car)
  end
end