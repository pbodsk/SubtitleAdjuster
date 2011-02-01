require 'rake/testtask'
require 'fileutils'
require 'find'

task :default => [:run_tests]

desc "run all tests"
task :run_tests do
  Rake::TestTask.new("run_tests") do |test|  
      test.pattern ="test/test_*.rb"
      test.verbose = true
      test.warning = true
  end
end

desc "remove all *.srt files"
task :clean do
  srt_files = Dir['*.srt']
  srt_files.each do |file|
    FileUtils.remove_file(file)
  end
end