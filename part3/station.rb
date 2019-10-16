class Station
  include InstanceCounter
  include Validation
  
  attr_reader :trains, :name

  @@stations = []

  validate :name, :presence

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
  end

  def train_action
    @trains.each { |train| yield(train)} if block_given?
  end

  def train_list
    train_action do |train|
      puts "Тип: #{train.class}. Номер: #{train.number}. Вагонов: #{train.cars}."
    end
  end

  def self.all
    @@stations
  end

  # прием поезда
  def add_train(train)
    @trains << train
  end

  # отправка поезда
  def launch_train(train)
    @trains.delete(train)
  end

end
