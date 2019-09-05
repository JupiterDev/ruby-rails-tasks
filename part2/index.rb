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
    trains_count = 0
    @trains.each do |train|
      (train.type == type) ? (trains_count += 1) : next
    end
    return "Число поездов с типом #{type}: #{trains_count}"
  end

  # отправка поезда
  def launch_train(train)
    trains.include?(train) ? trains.delete(train) : (puts "Данного поезда нет на станции.")
  end 

end

class Route
  attr_reader :start_station, :finish_station

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station
    @intermediate_stations = []
  end

  #добавить станцию в промежуточный маршрут
  def add_station(station)
    (!@intermediate_stations.include?(station) && (station != @start_station) && (station != @finish_station)) ? (@intermediate_stations << station) : (puts "Данная станция уже есть в промежуточном маршрует или это начальная/конечная станция.")
  end

  #удалить станцию из промежуточного маршрута
  def remove_station(station)
    @intermediate_stations.include?(station) ? @intermediate_stations.delete(station) : (puts "Невозможно удалить станцию, которой нет в промежуточном маршруте.")
  end

  #вывод всех станций маршрута (только названия)
  def stations
    puts @start_station.name
    @intermediate_stations.each do |station|
      puts station.name
    end  
    puts @finish_station.name
  end

  #вывод маршрута в виде массива
  def route_arr
    full_route = []
    full_route << @start_station
    @intermediate_stations.each do |station|
      full_route << station
    end
    full_route << @finish_station
  end
end

class Train
  attr_reader :current_speed, :type, :car_count, :current_station

  def initialize(number, type, car_count, route = nil)
    @number = number
    (type == "freight" || type == "passenger") ? (@type = type) : (raise 'Аргумент type задан неверно.')
    @car_count = car_count
    @route = route
    @current_speed = 0
    @current_station = route.start_station if route
  end

  #набор скорости
  def increase_speed
    @current_speed += 10
  end

  #торможение
  def stop
    @current_speed = 0
  end

  #прицепить вагон
  def add_car
    @current_speed == 0 ? @car_count += 1 : (puts "Невозможно прицепить вагон на ходу.")
  end

  #отцепить вагон
  def remove_car
    if (@current_speed == 0 && @car_count > 0)
      @car_count-= 1
    elsif @current_speed > 0
      puts "Невозможно отцепить вагон на ходу."
    elsif @car_count == 0
      puts "Невозможно отцепить вагон, потому что в поезде нет вагонов"
    end
  end

  #переместиться на следующую станцую маршрута
  def move_to_the_next_station
    if @route
      if @current_station != @route.finish_station
        @current_station = @route.route_arr[@route.route_arr.find_index(@current_station) + 1]
      else
        puts "Конечная. Следующей станции нет."
      end
    else
      puts "Маршрут дя поезда не задан."
    end
  end

  #переместиться на предыдущую станцую маршрута
  def move_to_the_previous_station
    if @route
      if @current_station != @route.start_station
        @current_station = @route.route_arr[@route.route_arr.find_index(@current_station) - 1]
      else
        puts "Это первая станция в маршруте."
      end
    else
      puts "Маршрут дя поезда не задан."
    end
  end

  #показать следующую станцию маршрута
  def next_station
    if @route
      if @current_station != @route.finish_station
        puts @route.route_arr[@route.route_arr.find_index(@current_station) + 1]
      else
        puts "Конечная. Следующей станции нет."
      end
    else
      puts "Маршрут дя поезда не задан."
    end
  end

  #показать предыдущую станцию маршрута
  def previous_station
    if @route
      if @current_station != @route.start_station
        puts @route.route_arr[@route.route_arr.find_index(@current_station) - 1]
      elsif
        puts "Это первая станция в маршруте."
      end
    else
      puts "Маршрут дя поезда не задан."
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