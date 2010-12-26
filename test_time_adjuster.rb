require_relative 'time_adjuster'
require 'test/unit'

class TestTimeAdjuster < Test::Unit::TestCase
  def test_can_move_forwards
    adjuster = TimeAdjuster.new("00:00:03,796 --> 00:00:07,465  ")
    line = adjuster.warp( "+", "00:00:01,000")
    assert_equal("00:00:04,796 --> 00:00:08,465", line)
  end

  def test_can_move_backwards
    adjuster = TimeAdjuster.new("00:00:03,796 --> 00:00:07,465  ")
    line = adjuster.warp( "-", "00:00:01,000")
    assert_equal("00:00:02,796 --> 00:00:06,465", line)
  end


end