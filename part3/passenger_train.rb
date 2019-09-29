class PassengerTrain < Train

  def add_car(car)
    super(car) if car.class == PassengerCar
  end

end
