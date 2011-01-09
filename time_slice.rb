class TimeSlice
  attr_accessor :hours, :minutes, :seconds, :miliseconds
  def initialize(input_line)
    #00:21:29,621
    @hours, @minutes, @seconds, @miliseconds = input_line.scan(/\d+/)
#    puts "hours: #{@hours}, minutes: #{@minutes}, seconds: #{@seconds}, miliseconds: #{@miliseconds}"
#    @hours = input_line[0,2].to_i
#    @minutes = input_line[3,2].to_i
#    @seconds = input_line[6,2].to_i
#    @miliseconds = input_line[9,3].to_i
  end
    
  def to_s
#    parse_miliseconds
#    parse_seconds
#    parse_minutes
#    parse_hours
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