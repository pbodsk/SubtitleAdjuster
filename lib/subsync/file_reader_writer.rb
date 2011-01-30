require_relative 'time_adjuster'

module SubSync
  class FileReaderWriter
    def initialize(file_to_read, direction, interval)
      @file = file_to_read
      @direction = direction
      @interval = interval
    end

    def execute
      output_file = File.new("warped_" + @file, "w+")
      File.open(@file, "r+") do |file|
        while line = file.gets 
          output_file.puts(line.gsub(/^\d{2}:\d{2}:\d{2},\d{3}\D*\d{2}:\d{2}:\d{2},\d{3}/) do
            time_adjuster = SubSync::TimeAdjuster.new(line)
            time_adjuster.warp(@direction, @interval)
          end )        
        end
      end
    end  
  end
end


