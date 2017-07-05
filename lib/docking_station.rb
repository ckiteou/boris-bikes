require_relative 'bike'

class DockingStation
DEFAULT_CONSTANT = 20
attr_reader :bikes

  def default_constant
    @default_constant = 20
  end

  def initialize
    @bikes = []
  end

  def release_bike
    fail 'No bikes available' if empty?
    @bikes.pop
  end

  def dock(bike)
    fail "Sorry, the dock is full" if full?
    @bikes << bike
  end

  private

  def full?
    @bikes.count >= DEFAULT_CONSTANT
  end

  def empty?
    @bikes.empty?
  end

end
