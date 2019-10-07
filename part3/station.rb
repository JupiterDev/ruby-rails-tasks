class Station
  include InstanceCounter
  include Validation
  
  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
  end

  def self.all
    @@stations
  end
  
  def validate!
    raise 'Ошибка! Имя не может быть пустым значением.' unless @name
    raise 'Ошибка! Имя должно быть больше 2 символов.' if @name.size < 3
  end

  # прием поезда
  def add_train(train)
    @trains << train
  end

  # кол-во поездов на станции по типу
  # def trains_by_type(type)
  #   @trains.count { |train| train.type == type }
  # end

  # отправка поезда
  def launch_train(train)
    @trains.delete(train)
  end

end
