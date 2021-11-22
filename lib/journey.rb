class Journey

  attr_reader :entry_station, :current_journey, :past_journeys

  def initialize
    @entry_station = nil
    @past_journeys = []
    @current_journey = {}
  end

  def in_journey?
    @entry_station == nil ? false : true
  end

  def journey_completed
  end

  def journey_start
    @travelling = true
  end

  def journey_end
    @travelling = false
  end

  def fare(zone, penalty)
    fare = 6 if penalty = true
  end
end