class PassengerTrain < Train

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def add_car(car)
    super(car) if car.class == PassengerCar
  end

end
