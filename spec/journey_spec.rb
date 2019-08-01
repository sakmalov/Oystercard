require 'journey'

describe Journey do
    it "has a class" do
        random_journey = Journey.new
    end

    subject{Journey.new}
    it "starts journey" do
        expect(subject).to respond_to(:entry_station, :exit_station)
    end

end
