class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount = 5)
    @balance += amount
  end
end