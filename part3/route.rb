class Route
  include InstanceCounter
  include Validation
  
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    validate!
  end
  
  def validate!
    # raise 'Ошибка! Начальная станция не может быть пустым значением.' unless stations[0]
    # raise 'Ошибка! Конечная станция не может быть пустым значением.' unless stations[1]
    raise "Ошибка! Сущность, введенная как начальная станция, не является станцией." unless stations[0].instance_of? Station
    raise "Ошибка! Сущность, введенная как конечная станция, не является станцией." unless stations[1].instance_of? Station
    raise "Ошибка! Начальная станция не может быть конечной станцией." if stations[0] === stations[1]
  end

  def first_station
    @stations.first
  end

  def finish_station
    @stations.last
  end

  # добавить станцию в промежуточный маршрут
  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  # удалить станцию из промежуточного маршрута
  def remove_station(station)
    if station != @stations.first && station != @stations.last
    @stations.delete(station)
    end
  end

  # вывести список всех станций
  def show_stations
    puts @stations
  end

end
