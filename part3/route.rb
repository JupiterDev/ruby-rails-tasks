class Route
  include InstanceCounter
  include Validate
  
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    validate!
  end
  
  def validate!
    raise "Ошибка! Сущность, введенная как начальная станция, не является станцией." unless first_station.instance_of? Station
    raise "Ошибка! Сущность, введенная как конечная станция, не является станцией." unless finish_station.instance_of? Station
    raise "Ошибка! Начальная станция не может быть конечной станцией." if first_station === finish_station
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
