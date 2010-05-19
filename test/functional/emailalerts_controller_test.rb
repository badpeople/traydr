require 'test_helper'

class EmailalertsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Emailalert.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Emailalert.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Emailalert.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to emailalert_url(assigns(:emailalert))
  end
  
  def test_edit
    get :edit, :id => Emailalert.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Emailalert.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Emailalert.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Emailalert.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Emailalert.first
    assert_redirected_to emailalert_url(assigns(:emailalert))
  end
  
  def test_destroy
    emailalert = Emailalert.first
    delete :destroy, :id => emailalert
    assert_redirected_to emailalerts_url
    assert !Emailalert.exists?(emailalert.id)
  end

  def test_create
    # create new alert            
    post :create, :emailalert => {:system_id=>1,:title=>"test email title",
                                  :body=>"test email body",
                                  :send_at=>Time.now,:status=>"NEW"}
  end
end
