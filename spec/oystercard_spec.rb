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

  describe "#touch_in" do 
    it "raise error if balance below 1" do
      expect{ subject.touch_in }.to raise_error "Balance needs to be 1 or more"
    end
    it "Change in_journey from false to true" do
      subject.top_up(20)
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end
  end
  
  describe "#touch_out" do
    it "Change in journey from true to false" do
      subject.top_up(20)
      subject.touch_in
      expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
      expect(subject.in_journey?).to eq(false)
    end
  end
end

