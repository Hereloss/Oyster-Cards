# frozen_string_literal: true

# Journey
class Journey
  attr_reader :journey_log

  def initialize
    @journey_log = JourneyLog.new
  end

  def fare(exit_station, inout)
    case penalty_fare(exit_station, inout)
    when true
      6
    when false
      if inout == 'In'
        0
      else
        calculate_fare(exit_station)
      end
    end
  end

  def penalty_fare(exit_station, inout)
    case inout
    when 'Out'
      out(exit_station)
    when 'In'
      inside(exit_station)
    end
  end

  def calculate_fare(exit_station)
    from = @journey_log.station_object.zone
    to = exit_station.zone
    return 5 if from == 1 || to == 1
    return (from - to).abs unless from == to

    1
  end

  def out(exit_station)
    if @journey_log.entry_station.nil?
      @journey_log.store_journey(exit_station)
      true
    else
      false
    end
  end

  def inside(exit_station)
    if @journey_log.travelling == true
      @journey_log.store_journey(exit_station)
      true
    else
      false
    end
  end
end
