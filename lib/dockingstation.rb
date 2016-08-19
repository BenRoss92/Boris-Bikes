require './lib/bike'

class DockingStation
  attr_reader :bikes
  attr_reader :capacity
  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    raise "no bikes" if @bikes.empty?
    @bikes.each do |bike|
      if bike.working? == false
        raise "broken bike"
      else
        @bikes.pop
      end
    end
  end

  def dock_bike(bike)
    raise "full!" if full?
    @bikes << bike
  end

  def group_broken
    broken_bikes = @bikes.find_all { |bike| bike.working? }
    broken_bikes
  end

private

  def full?
    @bikes.size >= @capacity
  end

end
