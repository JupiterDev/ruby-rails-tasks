class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  # прием поезда
  def add_train(train)
    @trains << train
  end

  # кол-во поездов на станции по типу
  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  # отправка поезда
  def launch_train(train)
    @trains.delete(train)
  end

end

class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def first_station
    @stations.first
  end

  def finish_station
    @stations.last
  end

  #добавить станцию в промежуточный маршрут
  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  #удалить станцию из промежуточного маршрута
  def remove_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end

  #вывести список всех станций
  def show_stations
    puts @stations
  end

end

class Train
  attr_reader :current_speed, :type, :car_count

  def initialize(number, type, car_count, route = nil)
    @number = number
    @type = type
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

  #прицепить вагон
  def add_car
    @car_count += 1 if @current_speed.zero?
  end

  #отцепить вагон
  def remove_car
    @car_count -= 1 if @current_speed.zero? && @car_count.positive?
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

end

# Класс Station (Станция):
# + Имеет название, которое указывается при ее создании
# + Может принимать поезда (по одному за раз)
# + Может возвращать список всех поездов на станции, находящиеся в текущий момент
# + Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# + Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

# Класс Route (Маршрут):
# + Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# + Может добавлять промежуточную станцию в список
# + Может удалять промежуточную станцию из списка
# + Может выводить список всех станций по-порядку от начальной до конечной

# Класс Train (Поезд):
# + Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# + Может набирать скорость
# + Может возвращать текущую скорость
# + Может тормозить (сбрасывать скорость до нуля)
# + Может возвращать количество вагонов
# + Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# + Может принимать маршрут следования (объект класса Route).
# + При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# + Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# + Возвращать предыдущую станцию, текущую, следующую, на основе маршрута