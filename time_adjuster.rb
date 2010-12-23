require_relative 'time_slice'

class TimeAdjuster
  def initialize(input_line)
    @start = TimeSlice.new(input_line[/^\d{2}:\d{2}:\d{2},\d{3}/])
    @end = TimeSlice.new(input_line[-14,12])
  end
  
  def warp(direction, interval)
    @interval_to_shift = TimeSlice.new(interval)
    @warpedStart = shift(@start, direction, @interval_to_shift)
    
    @warpedEnd = shift(@end, direction, @interval_to_shift)
    "#{@warpedStart} --> #{@warpedEnd}"
  end
  
  def shift(target, direction, interval)
    if "+".eql?(direction)
      return forwards(target, interval)
    elsif "-".eql?(direction)
      return backwards(target, interval)
    else
        puts "illegal value for direction, legal values are '+' and '-'"
    end
  end
  
private 
  def forwards(target, interval)
    target.miliseconds += interval.miliseconds
    if target.miliseconds > 999
      target.seconds += 1
      target.miliseconds -= 999
    end
    
    target.seconds += interval.seconds
    if target.seconds > 59
      target.minutes += 1
      target.seconds -= 59
    end
    
    target.minutes += interval.minutes
    if target.minutes > 59
      target.hours += 1
      target.minutes -= 59
    end
    
    target.hours += interval.hours
    return target
  end
  
  def backwards(target, interval)
    #00:00:03,937, 00:00:58,000
  
    target.miliseconds -= interval.miliseconds
    if target.miliseconds < 0
        target.seconds -= 1
        target.miliseconds = 999 + target.miliseconds
    end
    
    target.seconds -= interval.seconds
    if target.seconds < 0
        target.minutes -= 1
        target.seconds = 59 + target.seconds
    end
    
    target.minutes -= interval.minutes
    if target.minutes < 0
      target.hours -= 1
      target.minutes = 59 + target.seconds
    end
    
    target.hours -= interval.hours
    return target
  end
end