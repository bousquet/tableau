require File.dirname(__FILE__) + '/../test_helper'
require 'albums_controller'

# Re-raise errors caught by the controller.
class AlbumsController; def rescue_action(e) raise e end; end

class AlbumsControllerTest < Test::Unit::TestCase
  def setup
    @controller = AlbumsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
