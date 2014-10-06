require 'test_helper'

class VendasImportacaoControllerTest < ActionController::TestCase
  
  setup do
    @username = 'desafio'
    @password = 'passwd'
    basic = ActionController::HttpAuthentication::Basic 
    @credentials = basic.encode_credentials(@username, @password)
    request.headers['Authorization'] = @credentials
  end
  
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get importacao" do
    get :importacao
    assert_response :success
  end

end
