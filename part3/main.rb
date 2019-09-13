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

  def run
    run_output
    menu_answer_handler(menu_answer = gets.to_i)
  end

  def run_output
    puts "Введите цифру нужной команды:\n" \
         "1 - Создать станцию\n" \
         "2 - Создать поезд\n" \
         "3 - Создать маршрут и управлять станциями в нем (дабовить, удалить)\n" \
         "4 - Назначить маршрут поезду\n" \
         "5 - Добавить вагон к поезду\n" \
         "6 - Отцепить вагон от поезда\n" \
         "7 - Переместить поезд по маршруту вперед или назад\n" \
         "8 - Просмотреть список станций или список поездов на станции"
  end

  def menu_answer_handler(answer)
    case answer
      when 1
        case_1
      when 2
        case_2
      when 3
        case_3
      when 4
        case_4
      when 5
        case_5
      when 6
        case_6
      when 7
        case_7
      when 8
        case_8
    end
  end

  ##### 1 #####
  def case_1
    case_1_start_output
    create_station(gets.chomp)
    run
  end

  def case_1_start_output
    puts "Введите название станции."
  end

  def create_station(station_name)
    @stations[station_name] = Station.new(station_name)
    create_station_output(station_name)
  end

  def create_station_output(station_name)
    puts "Создана станция \"#{station_name}\"."
  end

  ##### 2 #####
  def case_2
    case_2_start_output
    number = gets.chomp
    case_2_choice_output
    type = gets.to_i
    create_train(number, type)
    run
  end

  def case_2_start_output
    puts "Введите номер поезда"
  end

  def case_2_choice_output
    puts "Введите\n" \
          "цифру 1, если хотите создать пассажирский поезд\n" \
          "цифру 2, если хотите создать грузовой поезд"
  end

  def create_train(number, type)
    if type == 1
      train = PassengerTrain.new(number)
      @trains[train.number] = train
    elsif type == 2
      train = CargoTrain.new(number)
      @trains[train.number] = train
    end
    create_train_final_uotput(number)
  end

  def create_train_final_uotput(number)
    puts "Cоздан поезд номер #{number}."
  end

  ##### 3 #####
  def case_3
    case_3_choice_1_output
    first_station = gets.chomp
    case_3_choice_2_output
    finish_station = gets.chomp
    case_3_choice_3_output
    route_name = gets.chomp
    create_route(first_station, finish_station, route_name)
    manage_stations
    run
  end

  def case_3_choice_1_output
    puts "Введите название первой станции маршрута."
  end

  def case_3_choice_2_output
    puts "Введите название последней станции маршрута."
  end

  def case_3_choice_3_output
    puts "Введите название маршрута."
  end

  def create_route(first_station, finish_station, route_name)
    route = Route.new(@stations[first_station], @stations[finish_station])
    @routes[route_name] = route
    create_route_final_output(route_name)
  end

  def create_route_final_output(route_name)
    puts "Создан маршрут \"#{route_name}\"."
  end

  def manage_stations
    manage_stations_start_output
    begin
      answer = gets.to_i
      if answer == 1
        manage_stations_choice_1_output
        station_name = gets.chomp
        add_station(route_name, station_name)
      elsif answer == 2
        manage_stations_choice_2_output
        station_name = gets.chomp
        remove_station(route_name, station_name)
      elsif answer != 3
        manage_stations_error_output
      end
      manage_stations_final_output
    end until answer == 3
  end

  def manage_stations_start_output
    puts "Управлять станциями в маршруте?\n" \
      "1 - Добавить промежуточную станцию\n" \
      "2 - Удалить промежуточную станцию\n" \
      "3 - Выход"
  end

  def manage_stations_choice_1_output
    puts "Введите название станции, которую хотите добавить."
  end

  def manage_stations_choice_2_output
    puts "Введите название станции, которую хотитие удалить."
  end

  def manage_stations_error_output
    puts "Некорректный ввод."
  end

  def manage_stations_final_output
    puts "Следующее действие с созданным маршрутом:\n" \
          "1 - Добавить промежуточную станцию\n" \
          "2 - Удалить промежуточную станцию\n" \
          "3 - Выход"
  end

  def add_station(route_name, station_name)
    if @stations[station_name]
      @routes[route_name].add_station(@stations[station_name])
    else
      station_availability_error_output
    end
  end

  def remove_station(route_name, station_name)
    if @stations[station_name]
      @routes[route_name].remove_station(@stations[station_name])
    else
      station_availability_error_output
    end
  end

  def station_availability_error_output
    puts "Станция с таких названием еще не создана."
  end

  ##### 4 #####
  def case_4
    case_4_choice_1_output
    train = gets.chomp
    case_4_choice_2_output
    route_name = gets.chomp
    set_route(train, route_name)
    run
  end

  def case_4_choice_1_output
    puts "Введите номер поезда, которому хотите назначить маршрут."
  end

  def case_4_choice_2_output
    puts "Введите название маршрута."
  end

  def set_route(train, route_name)
    @trains[train].set_route(@routes[route_name])
  end

  ##### 5 #####
  def case_5
    case_5_choice_1_output
    train = gets.chomp
    case_5_choice_2_output
    car = gets.chomp
    add_car(train, car)
    run
  end

  def case_5_choice_1_output
    puts "Введите номер поезда, которому нужно добавить вагон."
  end

  def case_5_choice_2_output
    puts "Введите номер вагона."
  end

  def add_car(train, car)
    @trains[train].add_car(car)
  end

  ##### 6 #####
  def case_6
    case_6_choice_output
    train = gets.chomp
    case_6_choice_2_output
    car = gets.chomp
    remove_car(train, car)
    run
  end  

  def case_6_choice_1_output
    puts "Введите номер поезда, у которого нужно отцепить вагон."
  end

  def case_6_choice_2_output
    puts "Введите номер вагона."
  end

  def remove_car(train, car)
    @trains[train].remove_car(car)
  end

  ##### 7 #####
  def case_7
    case_7_choice_1_output
    number = gets.chomp
    case_7_choice_2_output
    way = gets.to_i
    if way == 1
      move_train_forward(number)
    elsif way == 2
      move_train_back(number)
    end
    run
  end

  def case_7_choice_1_output
    puts "Укажите номер поезда."
  end

  def case_7_choice_2_output
    puts "Куда переместить поезд?\n" \
          "1 - Вперед\n" \
          "2 - Назад"
  end

  def move_train_forward(number)
    @trains[number].move_to_the_next_station
  end

  def move_train_back(number)
    @trains[number].move_to_the_previous_station
  end

  ##### 8 #####
  def case_8
    case_8_choice_1_output
    answer = gets.to_i
    if answer == 1
      show_stations
    elsif answer == 2
      station = gets.chomp
      show_trains(station)
    else
      case_8_error_output
    end
    run
  end

  def case_8_choice_1_output
    puts "Что вывести?\n" \
          "1 - Cписок станций\n" \
          "2 - Список поездов на станции"
  end

  def case_8_error_output
    puts "Некорректный ввод"
  end

  def show_stations
    puts @stations
  end

  def show_trains(station)
    puts @stations[station].trains
  end   

#   def seed
#     #1
#     create_train("346", 1)
#     create_train("465", 2)
#     create_train("678", 1)
#     create_train("253", 2)
#     puts "TASK 1 DONE"

#     #2
#     create_station("Station1")
#     create_station("Station5")
#     create_station("Station14")
#     create_station("Station23")
#     create_station("Station37")
#     puts "TASK 2 DONE"

#     #3
#     create_route("Station1", "Station37", "Main_route")
#     add_station("Main_route", "Station5")
#     add_station("Main_route", "Station14")
#     add_station("Main_route", "Station23")
#     remove_station("Main_route", "Station14")
#     puts "TASK 3 DONE"

#     #4
#     set_route("678", "Main_route")
#     set_route("346", "Main_route")
#     puts "TASK 4 DONE"

#     #5
#     add_car("678", "1")
#     add_car("678", "2")
#     add_car("678", "5")
#     add_car("465", "99")
#     puts "TASK 5 DONE"

#     #6
#     remove_car("678", "2")
#     puts "TASK 6 DONE"

#     #7
#     move_train_forward("465")
#     move_train_forward("465")
#     move_train_forward("465")
#     move_train_back("465")
#     puts "TASK 7 DONE"

#     #8
#     show_stations
#     puts "Station1:"
#     show_trains("Station1")
#     puts "Station5:"
#     show_trains("Station5")
#     puts "Station14:"
#     show_trains("Station14")
#     puts "Station23:"
#     show_trains("Station23")
#     puts "TASK 8 DONE"
#   end

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