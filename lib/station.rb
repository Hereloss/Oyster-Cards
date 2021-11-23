# frozen_string_literal: true

class Station
  attr_reader :name, :zone

  def initialize(name, zone = 1)
    @name = name
    valid_zone(zone)
  end

  def valid_zone(zone)
    raise 'Not a valid zone' unless (1..8).include? zone

    @zone = zone
  end
end
