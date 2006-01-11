require File.dirname(__FILE__) + '/../test_helper'

class PhotoTest < Test::Unit::TestCase
  fixtures :photos

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Photo, photos(:first)
  end
end
