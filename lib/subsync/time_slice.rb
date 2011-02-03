require_relative 'time_utils'
module SubSync
  class TimeSlice
    include SubSync::TimeUtils
    attr_accessor :hours, :minutes, :seconds, :miliseconds
    def initialize(input_line)
      @hours, @minutes, @seconds, @miliseconds = input_line.scan(/\d+/)
    end
    
    def to_s
      "#{@hours}:#{@minutes}:#{@seconds},#{@miliseconds}"
    end
  
    def to_miliseconds
      miliseconds = @miliseconds.to_i
      miliseconds += @seconds.to_i * SubSync::TimeUtils::MILISECONDS_IN_A_SECOND
      miliseconds += @minutes.to_i * (SubSync::TimeUtils::SECONDS_IN_A_MINUTE * SubSync::TimeUtils::MILISECONDS_IN_A_SECOND)
      miliseconds += @hours.to_i * (SubSync::TimeUtils::MINUTES_IN_AN_HOUR * SubSync::TimeUtils::SECONDS_IN_A_MINUTE * SubSync::TimeUtils::MILISECONDS_IN_A_SECOND)
      return miliseconds
    end 
  end
end