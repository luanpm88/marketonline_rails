require 'test_helper'

class AdClicksControllerTest < ActionController::TestCase
  setup do
    @ad_click = ad_clicks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ad_clicks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ad_click" do
    assert_difference('AdClick.count') do
      post :create, ad_click: { ad_id: @ad_click.ad_id, customer_code: @ad_click.customer_code, ip: @ad_click.ip }
    end

    assert_redirected_to ad_click_path(assigns(:ad_click))
  end

  test "should show ad_click" do
    get :show, id: @ad_click
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ad_click
    assert_response :success
  end

  test "should update ad_click" do
    patch :update, id: @ad_click, ad_click: { ad_id: @ad_click.ad_id, customer_code: @ad_click.customer_code, ip: @ad_click.ip }
    assert_redirected_to ad_click_path(assigns(:ad_click))
  end

  test "should destroy ad_click" do
    assert_difference('AdClick.count', -1) do
      delete :destroy, id: @ad_click
    end

    assert_redirected_to ad_clicks_path
  end
end
