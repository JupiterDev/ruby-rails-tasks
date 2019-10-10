class PassengerCar < Car

  # метод, который "занимает места" в вагоне
  def take_a_unit
    @available_units -= 1 if @available_units > 0
  end

end
