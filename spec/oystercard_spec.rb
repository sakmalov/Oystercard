require 'oystercard'
describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'Add money to card' do
    expect{ subject.top_up(5) }.to change { subject.balance }.by(5)
  end

  it 'raises an error if the maximum balance is exceeded' do
    amount = Oystercard::MAXIMUM_BALANCE
    subject.top_up(amount)
    expect{ subject.top_up 1 }.to raise_error 'Exceeded Maximum Balance'
  end

  it 'deducts money from the card' do
    subject.top_up(20)
    expect{ subject.deduct 5 }.to change { subject.balance }.by (-5)
  end

  # it 'checks the card for empty list of journeys by default' do
  #   expect(subject.journey).to eq()
  # end

  describe "#touch_in" do 
    let(:station){ double :station }

    it 'stores the entry station' do
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it "raise error if balance below 1" do
      expect{ subject.touch_in(station) }.to raise_error "Balance needs to be 1 or more"
    end
    it "Change in_journey from false to true" do
      subject.top_up(20)
      subject.touch_in(station)
    end
  end
  
  describe "#touch_out" do
    let(:station){ double :station }

    it "Change in journey from true to false" do
      subject.top_up(20)
      subject.touch_in(station)
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by(-Journey::NORMAL)
    end

    # it "check journey history" do
    #   subject.top_up(20)
    #   sta_1 = Station.new("Aldgate East")
    #   sta_2 = Station.new("Hammersmith")
    #   subject.touch_in(sta_1)
    #   subject.touch_out(sta_2)
    #   expect(subject.journey).to eq({ enter: sta_1, exit: sta_2})
    # end
  end

  describe "Produce a new journey" do

    it "check journey" do
      subject.top_up(20)
      sta_1 = Station.new()
      sta_2 = Station.new()
      subject.touch_in(sta_1)
      subject.touch_out(sta_2)
      expect(subject.journey.entry_station).to eq(sta_1)
      expect(subject.journey.exit_station).to eq(sta_2)
    end

    it "#fare_1" do
      subject.top_up(20)
      subject.touch_in(Station.new)
      subject.touch_out(Station.new)
      expect(subject.journey.fare).to eq(1)
    end

    it "#fare_2" do
      subject.top_up(20)
      subject.touch_in(Station.new)
      subject.touch_in(Station.new)
      expect(subject.journey.fare).to eq(6)
    end
  end
end

