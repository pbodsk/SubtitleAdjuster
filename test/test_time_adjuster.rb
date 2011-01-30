require_relative '../lib/subsync/time_adjuster'
require 'test/unit'

class TestTimeAdjuster < Test::Unit::TestCase
  def test_can_create_correct_start_and_end
    adjuster = SubSync::TimeAdjuster.new("00:00:03,796 --> 00:00:07,465")
    assert_equal("00:00:03,796", adjuster.start.to_s)
    assert_equal("00:00:07,465", adjuster.end.to_s)
  end
  
  
  def test_can_move_forwards
    adjuster = SubSync::TimeAdjuster.new("00:00:03,796 --> 00:00:07,465")
    line = adjuster.warp( "+", "00:00:01,000")
    assert_equal("00:00:04,796 --> 00:00:08,465", line)
  end

  def test_can_move_backwards
    adjuster = SubSync::TimeAdjuster.new("00:00:03,796 --> 00:00:07,465")
    line = adjuster.warp( "-", "00:00:01,000")
    assert_equal("00:00:02,796 --> 00:00:06,465", line)
  end
  
  def test_throws_error_if_moving_too_far
    adjuster = SubSync::TimeAdjuster.new("00:00:03,796 --> 00:00:07,465")
    assert_raise(RuntimeError){adjuster.warp( "-", "00:00:04,000")}
  end
  
  def test_will_add_to_seconds_if_addition_of_miliseconds_results_in_miliseconds_exceeding_999
    adjuster = SubSync::TimeAdjuster.new("00:00:00,750 --> 00:00:01,450")
    line = adjuster.warp( "+", "00:00:00,250")
    assert_equal("00:00:01,001 --> 00:00:01,700", line)
  end
  
  def test_will_add_to_minutes_if_addition_of_seconds_results_in_seconds_exceeding_60
    adjuster = SubSync::TimeAdjuster.new("00:00:03,000 --> 00:00:07,450")
    line = adjuster.warp( "+", "00:00:57,000")
    assert_equal("00:01:00,000 --> 00:01:04,450", line)
  end
  
  def test_will_add_to_minutes_if_addition_of_seconds_results_in_seconds_exceeding_60_test_2
    adjuster = SubSync::TimeAdjuster.new("00:00:03,010 --> 00:00:07,450")
    line = adjuster.warp( "+", "00:00:58,000")
    assert_equal("00:01:01,010 --> 00:01:05,450", line)
  end
  
  def test_will_add_to_hours_if_addition_of_minutes_results_in_minutes_exceeding_60
    adjuster = SubSync::TimeAdjuster.new("00:05:01,750 --> 00:05:02,450")
    line = adjuster.warp( "+", "00:55:00,000")
    assert_equal("01:00:01,750 --> 01:00:02,450", line)    
  end
  
  def test_will_add_to_hours_if_addition_of_minutes_results_in_minutes_exceeding_60_test_2
    adjuster = SubSync::TimeAdjuster.new("00:05:00,000 --> 00:06:00,000")
    line = adjuster.warp( "+", "00:56:00,000")
    assert_equal("01:01:00,000 --> 01:02:00,000", line)
  end
end