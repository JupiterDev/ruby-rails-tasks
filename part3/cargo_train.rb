class CargoTrain < Train

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def add_car(car)
    super(car) if car.class == CargoCar
  end

end
