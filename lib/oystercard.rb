class Oystercard
  attr_reader :balance 

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 3.50


  def initialize (balance = MAXIMUM_BALANCE)
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Exceeded Maximum Balance" if amount + balance > MAXIMUM_BALANCE
    @balance += amount 
  end

  def touch_in
    raise "Already in journey" if in_journey?
    raise "Balance needs to be 1 or more" if @balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    fail "Already out of journey" if !in_journey? 
    deduct(MINIMUM_CHARGE)
    @in_journey = false
  end
  
  def in_journey?
    @in_journey
  end

  def deduct(amount)
    @balance -= amount
  end
end

