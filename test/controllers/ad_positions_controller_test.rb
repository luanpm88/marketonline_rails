require 'test_helper'

class AdPositionsControllerTest < ActionController::TestCase
  setup do
    @ad_position = ad_positions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ad_positions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ad_position" do
    assert_difference('AdPosition.count') do
      post :create, ad_position: { description: @ad_position.description, name: @ad_position.name }
    end

    assert_redirected_to ad_position_path(assigns(:ad_position))
  end

  test "should show ad_position" do
    get :show, id: @ad_position
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ad_position
    assert_response :success
  end

  test "should update ad_position" do
    patch :update, id: @ad_position, ad_position: { description: @ad_position.description, name: @ad_position.name }
    assert_redirected_to ad_position_path(assigns(:ad_position))
  end

  test "should destroy ad_position" do
    assert_difference('AdPosition.count', -1) do
      delete :destroy, id: @ad_position
    end

    assert_redirected_to ad_positions_path
  end
end
