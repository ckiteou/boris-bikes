require_relative 'bike'

class DockingStation
  DEFAULT_CAPACITY = 20
  attr_accessor :capacity

  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
  end

  def release_bike
    fail 'No bikes available' if empty?
    bikes.each_with_index { |bike,i| return bikes.delete_at(i) unless bike.broken?}
    fail "No working bikes available"
  end

  def dock(bike)
    fail "Sorry, the dock is full" if full?
    bikes << bike
  end

  private
  attr_reader :bikes

  def full?
    bikes.count >= capacity
  end

  def empty?
    bikes.empty?
  end
end

=begin
station = DockingStation.new
bike = Bike.new
bike.report_broken
station.dock(bike)
p station.release_bike
=end
