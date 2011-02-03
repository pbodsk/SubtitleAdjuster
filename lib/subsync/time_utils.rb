module SubSync
  module TimeUtils
    MILISECONDS_IN_A_SECOND = 999
    SECONDS_IN_A_MINUTE = 60
    MINUTES_IN_AN_HOUR = 60
    
    def split_to_string_hours_minutes_seconds_and_miliseconds(miliseconds_value)
      hours, remaining = miliseconds_value.divmod(MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND)
      minutes, remaining = remaining.divmod(SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND)
      seconds, miliseconds = remaining.divmod(MILISECONDS_IN_A_SECOND)
      hours = see_if_padding_zero_is_needed(hours.to_s)
      minutes = see_if_padding_zero_is_needed(minutes.to_s)
      seconds = see_if_padding_zero_is_needed(seconds.to_s)
      miliseconds = see_if_padding_zero_is_needed(miliseconds.to_s)

      #extra check for miliseconds
      if miliseconds.length == 2
        miliseconds = "0" + miliseconds
      end
      [hours, minutes, seconds, miliseconds]
    end
 
    def see_if_padding_zero_is_needed(value)
      value = "0" + value if value.length == 1
      value
    end
  end
end