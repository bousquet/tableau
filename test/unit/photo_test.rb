require File.join(File.dirname(__FILE__), *%w[.. test_helper])

class PhotoTest < ActiveSupport::TestCase
  fixtures :photos

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Photo, photos(:first)
  end
end
