class Train
	attr_reader :number, :current_speed, :car_count
  
	def initialize(number, car_count, route = nil)
	  @number = number
    @car_count = car_count
	  @current_speed = 0
	  set_route(route)
	end
  
	#добавление пути и выполнение "прибытия поезда" на станцию
	def set_route(value)
	  @route = value
	  if @route
		  @route.stations.first.add_train(self)
		  @current_station_index = 0
	  end
	end
  
	#набор скорости
	def increase_speed(value)
	  @current_speed += value
	end
  
	#торможение
	def decrease_speed(value)
	  @current_speed -= value if @current_speed >= value
	end
  
	#переместиться на следующую станцию маршрута
	def move_to_the_next_station
	  if @route && (current_station != @route.finish_station)
      current_station.launch_train(self)
      next_station.add_train(self)
      @current_station_index += 1
	  end
	end
  
	#переместиться на предыдущую станцию маршрута
	def move_to_the_previous_station
	  if @route && (current_station != @route.first_station)
      current_station.launch_train(self)
      previous_station.add_train(self)
      @current_station_index -= 1
	  end
	end
  
	#следующая станция маршрута
	def next_station
	  if @route && (current_station != @route.finish_station)
		  @route.stations[@current_station_index + 1]
	  end
	end
  
	#текущая станция
	def current_station
	  if @route
		  @route.stations[@current_station_index]
	  end
	end
  
	#предыдущая станция маршрута
	def previous_station
	  if @route && (current_station != @route.first_station)
		  @route.stations[@current_station_index - 1]
	  end
  end

  #прицепить вагон
	def add_car
	  @car_count += 1 if @current_speed.zero?
	end
  
	#отцепить вагон
	def remove_car
	  @car_count -= 1 if @current_speed.zero? && @car_count.positive?
	end
  
end