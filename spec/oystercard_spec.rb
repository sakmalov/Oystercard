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

  it 'checks the card for empty list of journeys by default' do
    expect(subject.journey).to eq({})
  end

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
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end

    it "check journey history" do
      subject.top_up(20)
      sta_1 = Station.new("Aldgate East")
      sta_2 = Station.new("Hammersmith")
      subject.touch_in(sta_1)
      subject.touch_out(sta_2)
      expect(subject.journey).to eq({ enter: sta_1, exit: sta_2})
    end
  end


end

