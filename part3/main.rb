require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'passenger_car'
require_relative 'cargo_car'

class Control
  attr_reader :stations, :routes, :trains

  def initialize
    @stations = {}
    @routes = {}
    @trains = {}
  end

  def start
    puts "Введите цифру нужной команды:\n" +
       "1 - Создать станцию\n" +
       "2 - Создать поезд\n" +
       "3 - Создать маршрут и управлять станциями в нем (дабовить, удалить)\n" +
       "4 - Назначить маршрут поезду\n" +
       "5 - Добавить вагон к поезду\n" +
       "6 - Отцепить вагон от поезда\n" +
       "7 - Переместить поезд по маршруту вперед или назад\n" +
       "8 - Просмотреть список станций или список поездов на станции"
    menu_answer_handler(menu_answer = gets.to_i)
  end

  def menu_answer_handler(answer)
    case answer
      when 1
        puts "Введите название станции."
        create_station(gets.chomp)
      when 2
        puts "Введите номер поезда"
        number = gets.chomp
        puts "Введите\n" \
             "цифру 1, если хотите создать пассажирский поезд\n" \
             "цифру 2, если хотите создать грузовой поезд"
        type = gets.to_i
        create_train(number, type)
      when 3
        puts "Введите название первой станции маршрута."
        first_station = gets.chomp
        puts "Введите название последней станции маршрута."
        finish_station = gets.chomp
        puts "Введите название маршрута."
        route_name = gets.chomp
        create_route(first_station, finish_station, route_name)
        puts "Управлять станциями в маршруте?\n" \
         "1 - Добавить промежуточную станцию\n" \
         "2 - Удалить промежуточную станцию\n" \
         "3 - Выход"
        begin
          answer = gets.to_i
          if answer == 1
            puts "Введите название станции, которую хотите добавить."
            station_name = gets.chomp
            if @stations[station_name]
              add_station(route_name, station_name)
            else
              puts "Станция с таких названием еще не создана."
            end
          elsif answer == 2
            puts "Введите название станции, которую хотитие удалить."
            station_name = gets.chomp
            if @stations[station_name]
              remove_station(route_name, station_name)
            else
              puts "Станция с таких названием еще не создана."
            end
          elsif answer != 3
            puts "Некорректный ввод."
          end
          puts "Следующее действие с созданным маршрутом:\n" \
              "1 - Добавить промежуточную станцию\n" \
              "2 - Удалить промежуточную станцию\n" \
              "3 - Выход"
        end until answer == 3
      when 4
        puts "Введите номер поезда, которому хотите назначить маршрут."
        train = gets.chomp
        puts "Введите название маршрута."
        route_name = gets.chomp
        set_route(train, route_name)
      when 5
        puts "Введите номер поезда, которому нужно добавить вагон."
        train = gets.chomp
        add_car(train)
      when 6
        puts "Введите номер поезда, у которого нужно отцепить вагон."
        train = gets.chomp
        remove_car(train)
      when 7
        puts "Укажите номер поезда."
        number = gets.chomp
        puts "Куда переместить поезд?\n" \
             "1 - Вперед\n" \
             "2 - Назад"
        way = gets.to_i
        if way == 1
          move_train_forward(number)
        elsif way == 2
          move_train_back(number)
        end
      when 8
        puts "Что вывести?\n" \
             "1 - Cписок станций\n" \
             "2 - Список поездов на стацнии"
        answer = gets.to_i
        if answer == 1
          show_stations
        elsif answer == 2
          puts "Введите название станции"
          station = gets.chomp
          show_trains(station)
        end
      else
        puts "Некорректный ввод"
    end
  end

  # 1
  def create_station(station_name)
    @stations[station_name] = Station.new(station_name)
    puts "Создана станция \"#{station_name}\"."
  end

  # 2
  def create_train(number, type)
    if type == 1
      train = PassengerTrain.new(number)
      @trains[train.number] = train
    elsif type == 2
      train = CargoTrain.new(number)
      @trains[train.number] = train
    end
    puts "Cоздан поезд номер #{number}."
  end

  # 3
  def create_route(first_station, finish_station, route_name)
    route = Route.new(@stations[first_station], @stations[finish_station])
    @routes[route_name] = route
    puts "Создан маршрут \"#{route_name}\"."
  end

  # 3+
  def add_station(route_name, station_name)
    @routes[route_name].add_station(@stations[station_name])
  end

  # 3-
  def remove_station(route_name, station_name)
    @routes[route_name].remove_station(@stations[station_name])
  end

  # 4
  def set_route(train, route_name)
    @trains[train].set_route(@routes[route_name])
  end

  # 5
  def add_car(train)
    @trains[train].add_car
  end

  # 6
  def remove_car(train)
    @trains[train].remove_car
  end

  # 7
  def move_train_forward(number)
    @trains[number].move_to_the_next_station
  end

  # 7
  def move_train_back(number)
    @trains[number].move_to_the_previous_station
  end

  # 8
  def show_stations
    puts @stations
  end

  #8
  def show_trains(station)
    puts @stations[station].trains
  end

  # def seed
  #   #1
  #   create_train("346", 1)
  #   create_train("465", 2)
  #   create_train("678", 1)
  #   create_train("253", 2)
  #   puts "TASK 1 DONE"

  #   #2
  #   create_station("Station1")
  #   create_station("Station5")
  #   create_station("Station14")
  #   create_station("Station23")
  #   create_station("Station37")
  #   puts "TASK 2 DONE"

  #   #3
  #   create_route("Station1", "Station37", "Main_route")
  #   add_station("Main_route", "Station5")
  #   add_station("Main_route", "Station14")
  #   add_station("Main_route", "Station23")
  #   remove_station("Main_route", "Station14")
  #   puts "TASK 3 DONE"

  #   #4
  #   set_route("465", "Main_route")
  #   set_route("346", "Main_route")
  #   puts "TASK 4 DONE"

  #   #5
  #   add_car("678")
  #   add_car("678")
  #   add_car("678")
  #   add_car("465")
  #   puts "TASK 5 DONE"

  #   #6
  #   remove_car("678")
  #   puts "TASK 6 DONE"

  #   #7
  #   move_train_forward("465")
  #   move_train_forward("465")
  #   move_train_forward("465")
  #   move_train_back("465")
  #   puts "TASK 7 DONE"

  #   #8
  #   show_stations
  #   puts "Station1:"
  #   show_trains("Station1")
  #   puts "Station5:"
  #   show_trains("Station5")
  #   puts "Station14:"
  #   show_trains("Station14")
  #   puts "Station23:"
  #   show_trains("Station23")
  #   puts "TASK 8 DONE"

  # end

end

# Задание:

# -Разбить программу на отдельные классы (каждый класс в отдельном файле)
# -Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, 
# 	который будет содержать общие методы и свойства
# -Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. 
# 	В комментарии к методу обосновать, почему он был вынесен в private/protected
# -Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). К пассажирскому поезду 
#   можно прицепить только пассажирские, к грузовому - грузовые. 
# -При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода 
#   и сохраняться во внутреннем массиве поезда, в отличие от предыдущего задания, где мы 
#   считали только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.

# Добавить текстовый интерфейс:

# Создать программу в файле main.rb, которая будет позволять пользователю через 
# текстовый интерфейс делать следующее:
#      - Создавать станции
#      - Создавать поезда
#      - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#      - Назначать маршрут поезду
#      - Добавлять вагоны к поезду
#      - Отцеплять вагоны от поезда
#      - Перемещать поезд по маршруту вперед и назад
#      - Просматривать список станций и список поездов на станции