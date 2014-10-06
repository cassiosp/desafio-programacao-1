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
    assert_template :index
    assert_template layout: "layouts/application", partial: "_listagem"
  end

  test "should get importacao" do
    get :importacao
    assert_response :success
    assert_template :importacao
    assert_template layout: "layouts/application"
  end
  
  test "should post upload" do
    test_file = Rack::Test::UploadedFile.new(Rails.root.join("example_input.tab"), 'application/octet-stream')
    
    post :upload, :arquivo => test_file
    assert_response :success
    assert_template :upload
    assert_template layout: "layouts/application", partial: "_listagem"
  end

end
