class Oystercard

  attr_reader :balance, :limit

  def initialize
    @balance = 0
    @limit = 90.0
    @in_journey = false
  end

  def top_up(amount = 5.0)
    above_limit(amount)
    @balance += amount
  end

  def deduct(amount = 2.5) 
    below_zero(amount)
    @balance -= amount
  end
  
  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private 

  def above_limit(amount)
    raise "This exceeds your limit of £#{@limit}" unless (@balance + amount) < @limit
  end

  def below_zero(amount)
    raise "Not enough money" unless (@balance - amount) >= 0
  end
end