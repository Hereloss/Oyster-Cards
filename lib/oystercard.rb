require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :limit, :journey_cost
  JOURNEY_COST = 1
  DEFAULT_TOP_UP = 5
  LIMIT = 90

  def initialize(journey_cost = JOURNEY_COST,default_top_up = DEFAULT_TOP_UP, limit = LIMIT)
    @balance = 0
    @limit = limit
    @default_top_up = default_top_up
    @journey_cost = journey_cost
  end

  def top_up(amount = @default_top_up)
    above_limit(amount)
    @balance += amount
  end

  def touch_in(station,amount = @journey_cost)
    below_zero(amount)
    station = station.name if station.is_a?(Station) 
    @entry_station = station
    @current_journey[station] = nil
  end

  def touch_out(exit_station, amount = @journey_cost)
    deduct(amount)
    exit_station = exit_station.name if exit_station.is_a?(Station) 
    @current_journey[@entry_station] = exit_station
    @entry_station = nil
    @past_journeys << @current_journey
    @current_journey = {}
  end

  private

  def deduct(amount = @journey_cost) 
    below_zero(amount)
    @balance -= amount
  end

  def above_limit(amount)
    raise "This exceeds your limit of £#{@limit}" unless (@balance + amount) < @limit
  end

  def below_zero(amount)
    raise "Not enough money" unless (@balance - amount) >= 0
  end
end