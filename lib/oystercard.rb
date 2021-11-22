class Oystercard

  attr_reader :balance, :limit

  def initialize
    @balance = 0
    @limit = 90
  end

  def top_up(amount = 5)
    above_limit(amount)
    @balance += amount
  end

  def above_limit(amount)
    raise "This exceeds your limit of £#{@limit}" unless (@balance + amount) < @limit
  end
end