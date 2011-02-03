require_relative 'time_slice'
require_relative 'time_utils'

module SubSync
  class TimeAdjuster
    include SubSync::TimeUtils
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
      hours, minutes, seconds, miliseconds = split_to_string_hours_minutes_seconds_and_miliseconds(miliseconds_value)
      return "#{hours}:#{minutes}:#{seconds},#{miliseconds}"
    end
  end
end