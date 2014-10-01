require 'test_helper'

class VendasImportacaoControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should get importacao" do
    get :importacao
    assert_response :success
  end

end
