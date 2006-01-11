require File.dirname(__FILE__) + '/../test_helper'
require 'gallery_controller'

# Re-raise errors caught by the controller.
class GalleryController; def rescue_action(e) raise e end; end

class GalleryControllerTest < Test::Unit::TestCase
  def setup
    @controller = GalleryController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
