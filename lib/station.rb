class Station
  attr_reader :name, :zone
  def initialize(name, zone = 1)
    @name = name
    valid_zone(zone)
    
  end

  def valid_zone(zone)
    raise "Not a valid zone" if !(1..8).include? zone 
    @zone = zone
  end

end