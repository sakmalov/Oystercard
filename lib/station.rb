class Station
    def initialize(name = nil, zone = nil)
        @station_name = name
        @zone = zone
    end
    attr_reader :zone
end