class Train
  attr_reader :number, :wagons, :speed, :current_station, :type
  
   def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end

  def start(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if self.speed == 0 && wagon.type == self.type
  end

  def del_wagon(wagon)
    @wagons.delete(wagon) if self.speed == 0
  end

  def assign_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def move_next_station
    station = next_station
    if station
      @current_station.del_train(self)
      @current_station = station
      station.add_train(self)
    else 
      puts "\nНельзя переместить поезд на следующую станцию"
    end
  end

  def move_prev_station
    station = prev_station
    if station
      @current_station.del_train(self)
      @current_station = station
      station.add_train(self)
    else 
      puts "\nНельзя переместить поезд на предыдущую станцию"
    end
  end

  def next_station
    index = @route.stations.index(self.current_station)
    @route.stations[index + 1] if index && index != @route.stations.size - 1
  end

  def prev_station
    index = @route.stations.index(self.current_station)
    @route.stations[index - 1] if index && index > 0
  end

  def display_wagons
    puts "\nВагоны:"
    self.wagons.each_with_index { |wagon, i| puts "#{i + 1}. #{wagon.number}" }
  end
end