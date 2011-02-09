module SubSync
  module TimeUtils
    MILISECONDS_IN_A_SECOND = 999
    SECONDS_IN_A_MINUTE = 60
    MINUTES_IN_AN_HOUR = 60
    
    def split_to_string_hours_minutes_seconds_and_miliseconds(miliseconds_value)
      hours, remaining = miliseconds_value.divmod(MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND)
      minutes, remaining = remaining.divmod(SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND)
      seconds, miliseconds = remaining.divmod(MILISECONDS_IN_A_SECOND)
      
      format_values(hours.to_s, minutes.to_s, seconds.to_s, miliseconds.to_s)
    end
    
    def format_values(hours_string, minutes_string, seconds_string, miliseconds_string)
      return_array = [hours_string, minutes_string, seconds_string, miliseconds_string].map do |i|
        i.length == 1 ? "0" + i : i
      end
      if return_array[3].length == 2
        return_array[3].insert(0, "0")
      end
      return_array
    end
  end
end