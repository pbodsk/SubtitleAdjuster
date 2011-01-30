require_relative 'time_slice'

module SubSync
  class TimeAdjuster
    MILISECONDS_IN_A_SECOND = 999
    SECONDS_IN_A_MINUTE = 60
    MINUTES_IN_AN_HOUR = 60
    attr_reader :start, :end
  
    def initialize(input_line)
      time_slice_start, time_slice_end = input_line.chomp.split(/\s-->\s/)
      @start = SubSync::TimeSlice.new(time_slice_start)
      @end = SubSync::TimeSlice.new(time_slice_end)
    end
  
    def warp(direction, interval)
      @interval_to_shift = SubSync::TimeSlice.new(interval)
      @warpedStart = shift(@start, direction, @interval_to_shift)
    
      @warpedEnd = shift(@end, direction, @interval_to_shift)
      "#{@warpedStart} --> #{@warpedEnd}"
    end
  
private 

    def shift(target, direction, interval)  
      if "+".eql?(direction)
        return forwards(target, interval)
      elsif "-".eql?(direction)
        return backwards(target, interval)
      else
          raise "illegal value for direction, legal values are '+' and '-'"
      end
    end

    def forwards(target, interval)
      target_in_miliseconds = target.to_miliseconds
      interval_in_miliseconds = interval.to_miliseconds
      to_s(target_in_miliseconds + interval_in_miliseconds)
    end
  
    def backwards(target, interval)
      target_in_miliseconds = target.to_miliseconds
      interval_in_miliseconds = interval.to_miliseconds
      val = target_in_miliseconds - interval_in_miliseconds
      raise "trying to subtract a timecode larger than this one" if val < 0
      to_s(val)
    end
  
    def to_s(miliseconds_value)
      hours = miliseconds_value.div(MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND).to_s
      remaining = miliseconds_value.modulo(MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND)
      minutes = remaining.div(SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND).to_s
      remaining = remaining.modulo(SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND)
      seconds = remaining.div(MILISECONDS_IN_A_SECOND).to_s
      miliseconds = remaining.modulo(MILISECONDS_IN_A_SECOND).to_s
      hours = "0" + hours if hours.length == 1
      minutes = "0" + minutes if minutes.length ==1
      seconds = "0" + seconds if seconds.length == 1
      if miliseconds.length == 1
        miliseconds = "00" + miliseconds
      end
    
      if miliseconds.length == 2
        miliseconds = "0" + miliseconds
      end
      return "#{hours}:#{minutes}:#{seconds},#{miliseconds}"
    end
  end
end