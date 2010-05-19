require 'test_helper'

class SmsalertsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Smsalert.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Smsalert.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Smsalert.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to smsalert_url(assigns(:smsalert))
  end
  
  def test_edit
    get :edit, :id => Smsalert.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Smsalert.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Smsalert.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Smsalert.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Smsalert.first
    assert_redirected_to smsalert_url(assigns(:smsalert))
  end
  
  def test_destroy
    smsalert = Smsalert.first
    delete :destroy, :id => smsalert
    assert_redirected_to smsalerts_url
    assert !Smsalert.exists?(smsalert.id)
  end
end
