require './file_reader_writer'
direction = nil
fileName = nil
interval = nil

ARGV.each do |param|  
  if param =~ /\+|-/
    puts "found direction"
    direction = param
  end
  
  if param =~ /\.srt/
    puts "found fileName"
    fileName = param
  end
  
  if param =~ /\d{2}:\d{2}:\d{2},\d{3}/
    puts "found interval"
    interval = param
  end
end

if direction == nil
  puts "direction is missing. Give me a + if you'd like to add the interval or a - if you'd like to subtract the interval"
end

if fileName == nil
  puts "filename is missing. Give me a name for the file you'd like to adjust. Remember to include .srt. Example: inputFile.srt"
end

if interval == nil
  puts "interval is missing or wrongly formatted. I need an interval looking like this: hh:mm:ss,miliseconds. Example: 00:00:02,123"
end

if direction != nil && fileName != nil && interval != nil
  puts "we're ready"
  puts "warp..."
  fileReaderWriter = FileReaderWriter.new(fileName, direction, interval)
  fileReaderWriter.execute()
  puts "...OK done, your file is now adjusted and can be found as warped_#{fileName}"
end