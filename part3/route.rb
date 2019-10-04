class Route
  include InstanceCounter
  
  attr_reader :stations

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station
    @stations = [start_station, finish_station]
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end
  
  def validate!
    raise 'Ошибка! Начальная станция не может быть пустым значением.' unless @start_station
    raise 'Ошибка! Конечная станция не может быть пустым значением.' unless @finish_station
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
