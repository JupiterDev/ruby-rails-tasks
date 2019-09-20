class PassengerTrain < Train
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = []
  end

  def add_car
    super(PassengerCar.new)
  end

end
