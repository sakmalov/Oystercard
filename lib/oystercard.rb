require 'station'
require 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :journey
  attr_accessor :station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize (balance = MAXIMUM_BALANCE)
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @journey = nil
  end

  def top_up(amount)
    fail "Exceeded Maximum Balance" if amount + balance > MAXIMUM_BALANCE
    @balance += amount 
  end

  def touch_in(station)
    if in_journey? 
      puts "Already in journey"
      deduct(@journey.fare)
      return
    end
    raise "Balance needs to be 1 or more" if @balance < MINIMUM_BALANCE
    @in_journey = true
    @entry_station = station
    @journey = Journey.new(@entry_station, nil)
  end

  def touch_out(station)
    fail "Already out of journey" if !in_journey? 
    @entry_station = nil
    @in_journey = false
    @journey.exit_station = station
    deduct(@journey.fare)
  end
  
  def in_journey?
    !!entry_station
  end

  def deduct(amount)
    @balance -= amount
  end
end

