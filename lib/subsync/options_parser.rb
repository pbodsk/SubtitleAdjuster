require 'optparse'

module SubSync
  class OptionsParser
    attr_reader :direction
    attr_reader :file_name
    attr_reader :interval
    
    def initialize(argv)
      parse(argv)
      sanity_check
    end
    
private
    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = "Usage: subsync [options]"
        opts.on("-d", "--direction dir", String, "Direction of transformation, valid options are + and -") do |dir|
          @direction = dir
        end

        opts.on("-f", "--file file", String, "File to synchronize") do |file|
          @file_name = file
        end
        
        opts.on("-i", "--interval interval", String, "Interval to transform, required format hh:mm:ss,mss") do |interval|
          @interval = interval
        end
        
        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      
        begin
          argv << "-h" if argv.empty?
          opts.parse(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end    
    end

    def sanity_check
      raise "Please provide a filename with the -f parameter" if @file_name.nil? || @file_name.empty?
      raise "Please....I'm looking for directions!! Show me a direction, use the -d paramter" if @direction.nil? || @direction.empty?
      raise "Interval is not filled out, please use the -i parameter" if @interval.nil? || @interval.empty?
      raise "Interval is not filled out correctly, the correct format is hh:mm:ss,mss, example: 01:02:03,456" unless /\d{2}:\d{2}:\d{2},\d{3}/=~ @interval
    end
  end
end
  