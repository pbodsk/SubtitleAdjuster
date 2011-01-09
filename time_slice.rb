class TimeSlice
  attr_accessor :hours, :minutes, :seconds, :miliseconds
  def initialize(input_line)
    #00:21:29,621
    @hours, @minutes, @seconds, @miliseconds = input_line.scan(/\d+/)
  end
    
  def to_s
    "#{@hours}:#{@minutes}:#{@seconds},#{@miliseconds}"
  end
  
  def to_miliseconds
    miliseconds = @miliseconds.to_i
    miliseconds += @seconds.to_i * 999
    miliseconds += @minutes.to_i * (60 * 999)
    miliseconds += @hours.to_i * (60 * 60 * 999)
    return miliseconds
  end 
end