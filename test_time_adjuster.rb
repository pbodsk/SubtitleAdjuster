require_relative 'time_adjuster'
require 'test/unit'

class TestTimeAdjuster < Test::Unit::TestCase
  def test_can_create_correct_start_and_end
    adjuster = TimeAdjuster.new("00:00:03,796 --> 00:00:07,465")
    assert_equal("00:00:03,796", adjuster.start.to_s)
    assert_equal("00:00:07,465", adjuster.end.to_s)
  end
  
  
  def test_can_move_forwards
    adjuster = TimeAdjuster.new("00:00:03,796 --> 00:00:07,465")
    line = adjuster.warp( "+", "00:00:01,000")
    assert_equal("00:00:04,796 --> 00:00:08,465", line)
  end

  def test_can_move_backwards
    adjuster = TimeAdjuster.new("00:00:03,796 --> 00:00:07,465")
    line = adjuster.warp( "-", "00:00:01,000")
    assert_equal("00:00:02,796 --> 00:00:06,465", line)
  end
  
  def test_throws_error_if_moving_too_far
    adjuster = TimeAdjuster.new("00:00:03,796 --> 00:00:07,465")
    assert_raise(RuntimeError){adjuster.warp( "-", "00:00:04,000")}
  end
  
  def test_will_add_to_seconds_if_addition_of_miliseconds_results_in_miliseocnds_exceeding_999
    adjuster = TimeAdjuster.new("00:00:03,750 --> 00:00:07,450")
    line = adjuster.warp( "+", "00:00:00,250")
    assert_equal("00:00:04,001 --> 00:00:07,700", line)
  end
  
  def test_will_add_to_minutes_if_addition_of_seconds_results_in_seconds_exceeding_60
    adjuster = TimeAdjuster.new("00:00:03,750 --> 00:00:07,450")
    line = adjuster.warp( "+", "00:00:57,000")
    assert_equal("00:01:01,750 --> 00:01:05,450", line)
  end
  
  def test_will_add_to_hours_if_addition_of_minutes_results_in_minutes_exceeding_60
    adjuster = TimeAdjuster.new("00:05:01,750 --> 00:05:02,450")
    line = adjuster.warp( "+", "00:55:00,000")
    assert_equal("01:01:01,750 --> 01:01:02,450", line)    
  end


end