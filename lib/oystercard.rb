# frozen_string_literal: true

require_relative 'station'
require_relative 'journey'

# Creates functionality for an oystercard, touching in and out
class Oystercard
  attr_reader :balance, :limit, :journey_cost, :journey, :max_journey_cost

  JOURNEY_COST = 7.40
  DEFAULT_TOP_UP = 10
  LIMIT = 90

  def initialize(max_journey_cost = JOURNEY_COST, default_top_up = DEFAULT_TOP_UP, limit = LIMIT)
    @journey = Journey.new
    @balance = 0
    @limit = limit
    @default_top_up = default_top_up
    @max_journey_cost = max_journey_cost
  end

  def top_up(amount = @default_top_up)
    above_limit(amount)
    @balance += amount
  end

  def touch_in(station)
    below_zero(@max_journey_cost)
    station_name = station.name if station.is_a?(Station)
    if @journey.journey_log.travelling == true
      amount = @journey.fare('None', 'In')
      deduct(amount)
    end
    @journey.journey_log.journey_start(station_name, station)
  end

  def touch_out(exit_station)
    amount = @journey.fare(exit_station, 'Out')
    deduct(amount)
    exit_station = exit_station.name if exit_station.is_a?(Station)
    @journey.journey_log.journey_end(exit_station)
  end

  private

  def deduct(amount = @max_journey_cost)
    below_zero(amount)
    @balance -= amount
  end

  def above_limit(amount)
    raise "This exceeds your limit of £#{@limit}" unless (@balance + amount) < @limit
  end

  def below_zero(amount)
    raise 'Not enough money' unless (@balance - amount) >= 0
  end
end
