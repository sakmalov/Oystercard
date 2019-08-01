class Journey
    PENALTY = 6
    NORMAL = 1
    attr_reader :entry_station, :exit_station
    attr_writer :entry_station, :exit_station

    def initialize(entry_station = nil, exit_station = nil)
        @entry_station = entry_station
        @exit_station = exit_station
    end

    def fare
        if @exit_station == nil
            return PENALTY
        else
            return NORMAL
        end
    end
end

