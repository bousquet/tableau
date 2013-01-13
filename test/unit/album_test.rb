require File.join(File.dirname(__FILE__), *%w[.. test_helper])

class AlbumTest < ActiveSupport::TestCase
  fixtures :albums

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Album, albums(:first)
  end
end
