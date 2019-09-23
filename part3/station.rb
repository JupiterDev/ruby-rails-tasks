class Station
  include InstanceCounter
  
  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  def self.all
    @@stations
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
