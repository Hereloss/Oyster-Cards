class Journey

  attr_reader :entry_station, :current_journey, :past_journeys, :travelling

  def initialize
    @entry_station = nil
    @past_journeys = []
    @current_journey = {}
    @travelling = false
  end

  def in_journey?
    return @travelling
  end

  def journey_start(station, station_object = Station.new("W",1))
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

  def fare(exit_station, inout)
    penalty = penalty_fare(exit_station,inout)
    if penalty == true
      return 6
    elsif penalty == false
      if inout == "In"
        return 0
      else 
        return calculate_fare(exit_station)
      end
    end
  end

  def penalty_fare(exit_station,inout)
    if inout == "Out"
      if @entry_station == nil
        store_journey(exit_station)
        return true
      else
        return false
      end
    elsif inout == "In"
      if @travelling == true
        store_journey(exit_station)
        return true
      else
        return false
      end
    end
  end

  def store_journey(exit_station)
    exit_station = exit_station.name if exit_station.is_a?(Station) 
    @current_journey[@entry_station] = exit_station
    @entry_station = nil
    @past_journeys << @current_journey
    @current_journey = {}
  end

  def calculate_fare(exit_station)
    from = @station_object.zone
    to = exit_station.zone
    return 5 if ( from == 1 || to == 1)
    return abs(from - to)
  end
end