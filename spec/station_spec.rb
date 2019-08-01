require 'station'

describe Station do
    subject{Station.new}
    it "check the station zone" do
        expect(subject).to respond_to(:zone)
    end
end