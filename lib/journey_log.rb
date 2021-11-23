# frozen_string_literal: true

class Journey_log
  attr_reader :entry_station, :current_journey, :past_journeys, :travelling, :station_object

  def initialize
    @entry_station = nil
    @past_journeys = []
    @current_journey = {}
    @travelling = false
  end

  def in_journey?
    @travelling
  end

  def journey_start(station, station_object = Station.new('W', 1))
    @station_object = station_object
    @travelling = true
    @entry_station = station
    @current_journey[station] = nil
  end

  def journey_end(exit_station)
    @travelling = false
    exit_station = exit_station.name if exit_station.is_a?(Station)
    store_journey(exit_station)
  end

  def journeys
    @past_journeys
  end

  def store_journey(exit_station)
    exit_station = exit_station.name if exit_station.is_a?(Station)
    @current_journey[@entry_station] = exit_station
    @entry_station = nil
    @past_journeys << @current_journey
    @current_journey = {}
  end
end
