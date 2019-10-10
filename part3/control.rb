require_relative 'company_module'
require_relative 'instance_counter_module'
require_relative 'validation_module'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'passenger_car'
require_relative 'cargo_car'

class Control
  attr_reader :stations, :routes, :trains, :cars

  def initialize
    @stations = {}
    @routes = {}
    @trains = {}
    @cars = {}
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
         "8 - Просмотреть список станций или список поездов на станции\n" \
         "9 - Создать вагон\n" \
         "10 - Посмотреть список вагонов у поезда\n" \
         "11 - Посмотреть список поездов на станции\n" \
         '0 - Выход'
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
    when 9
      case_9
    when 10
      case_10
    when 11
      case_11
    when 0
      case_0
    else
      case_error
    end
  end

  ##### 1 #####
  def case_1
    case_1_start_output
    create_station(gets.chomp)
    run
  rescue Exception => e
    puts "#{e.message}"
    retry
  end

  def case_1_start_output
    puts 'Введите название станции.'
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
    raise "Ошибка! Введен неверный тип поезда." if type != 1 && type != 2
    create_train(number, type)
    create_train_final_output(number)
    run
  rescue Exception => e
    puts "#{e.message}"
    retry
  end

  def case_2_start_output
    puts 'Введите номер поезда'
  end

  def case_2_choice_output
    puts "Введите\n" \
          "цифру 1, если хотите создать пассажирский поезд\n" \
          'цифру 2, если хотите создать грузовой поезд'
  end

  def create_train(number, type)
    if type == 1
      train = PassengerTrain.new(number)
      @trains[train.number] = train
    elsif type == 2
      train = CargoTrain.new(number)
      @trains[train.number] = train
    end
  end

  def create_train_number_error
    puts "ОШИБКА! Был введен невалидный номер поезда."
  end

  def create_train_type_error
    puts "ОШИБКА! Неверно введен тип поезда. Попробуйте еще раз."
  end

  def create_train_final_output(number)
    puts "Cоздан поезд номер #{number}."
  end

  ##### 3 #####
  def case_3
    case_3_choice_1_output
    first_station = gets.chomp
    case_3_check_station(first_station)
    case_3_choice_2_output
    finish_station = gets.chomp
    case_3_check_station(first_station)
    case_3_choice_3_output
    route_name = gets.chomp
    create_route(first_station, finish_station, route_name)
    manage_stations(route_name)
    run
  rescue Exception => e
    puts "#{e.message}"
    retry
  end

  def case_3_choice_1_output
    puts 'Введите название первой станции маршрута.'
  end

  def case_3_choice_2_output
    puts 'Введите название последней станции маршрута.'
  end

  def case_3_choice_3_output
    puts 'Введите название маршрута.'
  end

  def case_3_check_station(station)
    case_3_check_station_error_output unless @stations[station]
  end

  def case_3_check_station_error_output
    puts 'Станции не найдено. Введите данные еще раз.'
    case_3
  end

  def create_route(first_station, finish_station, route_name)
    route = Route.new(@stations[first_station], @stations[finish_station])
    @routes[route_name] = route
    create_route_final_output(route_name)
  end

  def create_route_final_output(route_name)
    puts "Создан маршрут \"#{route_name}\"."
  end

  def manage_stations(route_name)
    manage_stations_start_output
    begin
      answer = gets.to_i
      if answer == 1
        manage_stations_choice_1_output
        station_name = gets.chomp
        manage_stations_check(station_name, route_name)
        add_station(route_name, station_name)
      elsif answer == 2
        manage_stations_choice_2_output
        station_name = gets.chomp
        manage_stations_check(station_name, route_name)
        remove_station(route_name, station_name)
      elsif answer != 3
        incorrect_input_error_message
      end
      manage_stations_final_output
    end until answer == 3
  end

  def manage_stations_check(station, route_name)
    manage_stations_error(route_name) unless @stations[station]
  end

  def manage_stations_error(route_name)
    puts 'Станция не найдена.'
    manage_stations(route_name)
  end

  def manage_stations_start_output
    puts "Управлять станциями в маршруте?\n" \
      "1 - Добавить промежуточную станцию\n" \
      "2 - Удалить промежуточную станцию\n" \
      '3 - Выход'
  end

  def manage_stations_choice_1_output
    puts 'Введите название станции, которую хотите добавить.'
  end

  def manage_stations_choice_2_output
    puts 'Введите название станции, которую хотитие удалить.'
  end

  def manage_stations_final_output
    puts "Следующее действие с созданным маршрутом:\n" \
          "1 - Добавить промежуточную станцию\n" \
          "2 - Удалить промежуточную станцию\n" \
          '3 - Выход'
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
    puts 'Станция с таких названием еще не создана.'
  end

  ##### 4 #####
  def case_4
    case_4_choice_1_output
    train = gets.chomp
    case_4_check_train(train)
    case_4_choice_2_output
    route_name = gets.chomp
    case_4_check_route(route_name)
    set_route(train, route_name)
    run
  end

  def case_4_check_train(train)
    case_4_check_train_error_output unless @trains[train]
  end

  def case_4_check_train_error_output
    puts 'Данного поезда не найдено. Введите данные еще раз.'
    case_4
  end

  def case_4_check_route(route)
    case_4_check_route_error_output unless @routes[route]
  end

  def case_4_check_route_error_output
    puts 'Данный маршрут не был создан. Введите данные еще раз.'
    case_4
  end

  def case_4_choice_1_output
    puts 'Введите номер поезда, которому хотите назначить маршрут.'
  end

  def case_4_choice_2_output
    puts 'Введите название маршрута.'
  end

  def set_route(train, route_name)
    @trains[train].set_route(@routes[route_name])
  end

  def somemet(car)
    puts car
  end

  ##### 5 #####
  def case_5
    case_5_choice_1_output
    train = gets.chomp
    case_5_choice_2_output
    car = gets.chomp
    @trains[train].add_car(@cars[car]) if @cars[car] && @trains[train]
    run
  end

  def case_5_choice_1_output
    puts 'Введите номер поезда, которому нужно добавить вагон.'
  end

  def case_5_choice_2_output
    puts 'Введите номер вагона.'
  end

  ##### 6 #####
  def case_6
    case_6_choice_1_output
    train = gets.chomp
    case_6_choice_2_output
    car = gets.chomp
    @trains[train].remove_car(@cars[car]) if @cars[car] && @trains[train]
    run
  end

  def case_6_choice_1_output
    puts 'Введите номер поезда, у которого нужно отцепить вагон.'
  end

  def case_6_choice_2_output
    puts 'Введите номер вагона.'
  end

  def remove_car(train, car_index)
    @trains[train].remove_car(car_index)
  end

  ##### 7 #####
  def case_7
    case_7_choice_1_output
    number = gets.chomp
    case_7_choice_2_output
    way = gets.chomp
    if way == 1
      move_train_forward(number)
    elsif way == 2
      move_train_back(number)
    end
    run
  end

  def case_7_choice_1_output
    puts 'Укажите номер поезда.'
  end

  def case_7_choice_2_output
    puts "Куда переместить поезд?\n" \
          "1 - Вперед\n" \
          '2 - Назад'
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
      case_8_choice_2_output
      station = gets.chomp
      show_trains(station)
    else
      incorrect_input_error_message
    end
    run
  end

  def case_8_choice_1_output
    puts "Что вывести?\n" \
          "1 - Cписок станций\n" \
          '2 - Список поездов на станции'
  end

  def case_8_choice_2_output
    puts "Введите номер станции"
  end

  def show_stations
    puts @stations
  end

  def show_trains(station)
    puts @stations[station].trains
  end

  ##### 9 #####
  def case_9
    case_9_choice_1_output
    car_type = gets.chomp
    case_9_choice_2_output
    number = gets.chomp
    case_9_choice_3_output
    quantity = gets.to_i
    if car_type == "1"
      puts "1"
      @cars[number] = PassengerCar.new(quantity)
      puts @cars[number]
    elsif car_type == "2"
      puts "2"
      @cars[number] = CargoCar.new(quantity)
      puts @cars[number]
    else
      incorrect_input_error_message
    end
    run
  end

  def case_9_choice_1_output
    puts "Какого типа вагон хотите создать\n" \
      "1 - Пассажирский\n" \
      "2 - Грузовой"
  end

  def case_9_choice_2_output
    puts "Введите номер(id) вагона"
  end

  def case_9_choice_3_output
    puts "Введите общий объем или общее кол-во мест"
  end

  ##### 10 #####
  def case_10
    case_10_choice_output
    number = gets.chomp
    @trains[number].car_list
    run
  end

  def case_10_choice_output
    puts "Введите номер поезда"
  end
  
  ##### 11 #####
  def case_11
    case_11_choice_output
    name = gets.chomp
    @stations[name].train_list
  end

  def case_11_choice_output
    puts "Введите название станции"
  end

  ##### 0 #####
  def case_0
    nil
  end
  
  def case_error
    incorrect_input_error_message
    run
  end

  def incorrect_input_error_message
    puts 'Некорректный ввод.'
  end

  # def seed
  #   # 1
  #   create_train('346', 1)
  #   create_train('465', 2)
  #   create_train('678', 1)
  #   create_train('253', 2)
  #   puts 'TASK 1 DONE'

  #   # 2
  #   create_station('Station1')
  #   create_station('Station5')
  #   create_station('Station14')
  #   create_station('Station23')
  #   create_station('Station37')
  #   puts 'TASK 2 DONE'

  #   # 3
  #   create_route('Station1', 'Station37', 'Main_route')
  #   add_station('Main_route', 'Station5')
  #   add_station('Main_route', 'Station14')
  #   add_station('Main_route', 'Station23')
  #   remove_station('Main_route', 'Station14')
  #   puts 'TASK 3 DONE'

  #   # 4
  #   set_route('678', 'Main_route')
  #   set_route('346', 'Main_route')
  #   puts 'TASK 4 DONE'

  #   # 5
  #   add_car('678', '1')
  #   add_car('678', '2')
  #   add_car('678', '5')
  #   add_car('465', '99')
  #   puts 'TASK 5 DONE'

  #   # 6
  #   remove_car('678', '2')
  #   puts 'TASK 6 DONE'

  #   # 7
  #   move_train_forward('465')
  #   move_train_forward('465')
  #   move_train_forward('465')
  #   move_train_back('465')
  #   puts 'TASK 7 DONE'

  #   # 8
  #   show_stations
  #   puts 'Station1:'
  #   show_trains('Station1')
  #   puts 'Station5:'
  #   show_trains('Station5')
  #   puts 'Station14:'
  #   show_trains('Station14')
  #   puts 'Station23:'
  #   show_trains('Station23')
  #   puts 'TASK 8 DONE'
  # end

end
