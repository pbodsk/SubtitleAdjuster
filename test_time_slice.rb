require_relative 'time_slice'
require 'test/unit'

class TestTimeSlice < Test::Unit::TestCase
  def test_can_create_time_slice
    time_slice = TimeSlice.new("01:02:03,456")
    assert_equal("01", time_slice.hours)
    assert_equal("02", time_slice.minutes)
    assert_equal("03", time_slice.seconds)
    assert_equal("456", time_slice.miliseconds)
  end
  
  def test_can_return_correct_formatted_string
    string_value = "01:02:03,456"
    time_slice = TimeSlice.new(string_value)
    assert_equal(string_value, time_slice.to_s)
  end
  
  def test_can_return_miliseconds
      string_value = "01:02:03,456"
      miliseconds_value = 3723456
      time_slice = TimeSlice.new(string_value)
      assert_equal(time_slice.to_miliseconds, miliseconds_value)
  end
end