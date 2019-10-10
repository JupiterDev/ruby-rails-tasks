class CargoCar < Car
  
  # метод, который "занимает объем" в вагоне
  def take_units(value)
    @available_units -= value if @available_units > 0 && @available_units >= value
  end

end
