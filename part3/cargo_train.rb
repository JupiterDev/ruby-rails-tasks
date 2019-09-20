class CargoTrain < Train
  def initialize(number, route = nil)
    @number = number
    @route = route
    @cars = []
  end

  def add_car
    super(CargoCar.new)
  end

end
