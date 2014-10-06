require 'test_helper'

class VendasImportacaoControllerTest < ActionController::TestCase
  
  setup do
    @username = 'desafio'
    @password = 'passwd'
    basic = ActionController::HttpAuthentication::Basic 
    @credentials = basic.encode_credentials(@username, @password)
    request.headers['Authorization'] = @credentials
  end
  
  test "correct credentials" do
    get :index
    assert_response :success
  end
  
  test 'missing credentials' do
    request.headers['Authorization'] = ''
    get :index
    assert_response 401
  end
  
  test 'invalid credentials' do
    request.headers['Authorization'] = 'someFake'
    get :index
    assert_response 401
  end
  
  test 'unathorized in proper realm' do
    request.headers['Authorization'] = ''
    get :index
    assert_equal 'Basic realm="Application"', response.headers['WWW-Authenticate']
  end

end
