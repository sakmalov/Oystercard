require 'station'

class Oystercard
  attr_reader :balance, :entry_station, :journey
  attr_accessor :station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 3.50

  def initialize (balance = MAXIMUM_BALANCE)
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @journey = {}
  end

  def top_up(amount)
    fail "Exceeded Maximum Balance" if amount + balance > MAXIMUM_BALANCE
    @balance += amount 
  end

  def touch_in(station)
    raise "Already in journey" if in_journey?
    raise "Balance needs to be 1 or more" if @balance < MINIMUM_BALANCE
    @in_journey = true
    @entry_station = station
  end

  def touch_out(station)
    fail "Already out of journey" if !in_journey? 
    deduct(MINIMUM_CHARGE)
    @journey = { enter: @entry_station, exit: station}
    @entry_station = nil
    @in_journey = false
  end
  
  def in_journey?
    !!entry_station
  end

  def deduct(amount)
    @balance -= amount
  end
end

