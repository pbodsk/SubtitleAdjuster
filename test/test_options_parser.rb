require_relative '../lib/subsync/options_parser'
require 'test/unit'

class TestOptionsParser < Test::Unit::TestCase
  def test_can_create
    argv = ["-d", "+", "-f", "somefile", "-i", "01:02:03,456"]
    opts = SubSync::OptionsParser.new(argv)
    assert_equal("+", opts.direction)
    assert_equal("somefile", opts.file_name)
    assert_equal("01:02:03,456", opts.interval)
  end
  
  def test_fails_if_missing_directory
    argv = ["-f", "somefile", "-i", "01:02:03,456"]
    assert_raise(RuntimeError){SubSync::OptionsParser.new(argv)}
  end

  def test_fails_if_missing_interval
    argv = ["-d", "+", "-f", "somefile"]
    assert_raise(RuntimeError){SubSync::OptionsParser.new(argv)}
  end

  def test_fails_if_missing_filename
    argv = ["-d", "+", "-i", "01:02:03,456"]
    assert_raise(RuntimeError){SubSync::OptionsParser.new(argv)}
  end

  def test_fails_if_wrongly_formatted_interval_string
    argv = ["-d", "+", "-f", "somefile", "-i", "01:02:03:456"]
    assert_raise(RuntimeError){SubSync::OptionsParser.new(argv)}
  end


end