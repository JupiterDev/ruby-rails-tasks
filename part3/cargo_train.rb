class CargoTrain < Train

  def add_car(car)
    super(car) if car.class == CargoCar
  end

end
