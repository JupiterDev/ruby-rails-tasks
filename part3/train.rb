class Train
  attr_reader :number, :current_speed, :cars

  def initialize(number, route = nil)
    @number = number
    @cars = []
    @current_speed = 0
    set_route(route)
  end

  # добавление пути и выполнение "прибытия поезда" на станцию
  def set_route(value)
    @route = value
    if @route
      @route.stations.first.add_train(self)
      @current_station_index = 0
    end
  end

  # набор скорости
  def increase_speed(value)
    @current_speed += value
  end

  # торможение
  def decrease_speed(value)
    @current_speed -= value if @current_speed >= value
  end

  # переместиться на следующую станцию маршрута
  def move_to_the_next_station
    if @route && (current_station != @route.finish_station)
      current_station.launch_train(self)
      next_station.add_train(self)
      @current_station_index += 1
    end
  end

  # переместиться на предыдущую станцию маршрута
  def move_to_the_previous_station
    if @route && (current_station != @route.first_station)
      current_station.launch_train(self)
      previous_station.add_train(self)
      @current_station_index -= 1
    end
  end

  # следующая станция маршрута
  def next_station
    if @route && (current_station != @route.finish_station)
      @route.stations[@current_station_index + 1]
    end
  end

  # текущая станция
  def current_station
    if @route
      @route.stations[@current_station_index]
    end
  end

  # предыдущая станция маршрута
  def previous_station
    if @route && (current_station != @route.first_station)
      @route.stations[@current_station_index - 1]
    end
  end

  # прицепить вагон
  def add_car
    if self.class == CargoTrain
      add_car!(CargoCar.new)
    elsif self.class == PassengerTrain
      add_car!(PassengerCar.new)
    end
  end

  # отцепить вагон
  def remove_car(index)
    @cars.delete_at(index) if @current_speed.zero?
  end

  protected

  # добавлен в protected, потому что не должен быть 
  # вызван "из вне" класса, но может быть использован в подклассах
  def add_car!(car)
    @cars << car
  end

end
