require 'test_helper'

class AuditoriaControllerTest < ActionController::TestCase
  test "should get accesos" do
    get :accesos
    assert_response :success
  end

end
