require_relative 'time_adjuster'

class FileReaderWriter
  def initialize(file_to_read, direction, interval)
    @file = file_to_read
    @direction = direction
    @interval = interval
  end

  def execute
    outputFile = File.new("warped_" + @file, "w+")
    File.open(@file, "r+") do |file|
      while line = file.gets 
        if line =~ /^\d{2}:\d{2}:\d{2},\d{3}\D*\d{2}:\d{2}:\d{2},\d{3}/
          timeAdjuster = TimeAdjuster.new(line)
          outputFile.puts timeAdjuster.warp(@direction, @interval)
        else
          outputFile.puts line
        end
      end
    end
  end
end


