module SubSync
  class TimeSlice
    MILISECONDS_IN_A_SECOND = 999
    SECONDS_IN_A_MINUTE = 60
    MINUTES_IN_AN_HOUR = 60
  
    attr_accessor :hours, :minutes, :seconds, :miliseconds
    def initialize(input_line)
      @hours, @minutes, @seconds, @miliseconds = input_line.scan(/\d+/)
    end
    
    def to_s
      "#{@hours}:#{@minutes}:#{@seconds},#{@miliseconds}"
    end
  
    def to_miliseconds
      miliseconds = @miliseconds.to_i
      miliseconds += @seconds.to_i * MILISECONDS_IN_A_SECOND
      miliseconds += @minutes.to_i * (SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND)
      miliseconds += @hours.to_i * (MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND)
      return miliseconds
    end 
  end
end