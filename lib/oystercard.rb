class Oystercard
  attr_reader :balance 

  MAXIMUM_BALANCE = 90

  def initialize (balance = MAXIMUM_BALANCE)
    @balance = 0
  end

  def top_up(amount)
    fail "Exceeded Maximum Balance" if amount + balance > MAXIMUM_BALANCE
    @balance += amount 
  end
end