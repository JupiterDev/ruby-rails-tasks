class Route
  include InstanceCounter
  include Validation
  
  attr_reader :stations

  validate :start_station, :type, Station
  validate :finish_station, :type, Station

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    validate!
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
