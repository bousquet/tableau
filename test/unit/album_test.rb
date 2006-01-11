require File.dirname(__FILE__) + '/../test_helper'

class AlbumTest < Test::Unit::TestCase
  fixtures :albums

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Album, albums(:first)
  end
end
