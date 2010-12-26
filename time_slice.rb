class TimeSlice
  attr_accessor :hours, :minutes, :seconds, :miliseconds
  def initialize(input_line)
    #00:21:29,621
    @hours = input_line[0,2].to_i
    @minutes = input_line[3,2].to_i
    @seconds = input_line[6,2].to_i
    @miliseconds = input_line[9,3].to_i
  end
    
  def to_s
    parse_miliseconds
    parse_seconds
    parse_minutes
    parse_hours
    "#{@hours}:#{@minutes}:#{@seconds},#{@miliseconds}"
  end
  
  private 
    def parse_miliseconds
      if @miliseconds < 0
        @miliseconds = "000"
      elsif @miliseconds < 10
        @miliseconds = "00" + @miliseconds.to_s
      elsif @miliseconds < 100
        @miliseconds = "0" + @miliseconds.to_s
      end
    end
    
    def parse_seconds
      if @seconds < 0 || @seconds > 59
        @seconds = "00"
      elsif @seconds < 10
        @seconds = "0" + @seconds.to_s
      end
    end
      
    def parse_minutes
      if @minutes < 0 || @minutes > 59
        @minutes = "00"
      elsif @minutes < 10
        @minutes = "0" + @minutes.to_s
      end
    end
    
    def parse_hours
      if @hours < 0 || @hours > 59
        @hours = "00"
      elsif @hours < 10
        @hours = "0" + @hours.to_s
      end
    end
    
end