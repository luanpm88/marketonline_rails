require 'test_helper'

class CatgroupsControllerTest < ActionController::TestCase
  setup do
    @catgroup = catgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catgroup" do
    assert_difference('Catgroup.count') do
      post :create, catgroup: { cat_ids: @catgroup.cat_ids, image: @catgroup.image, name: @catgroup.name }
    end

    assert_redirected_to catgroup_path(assigns(:catgroup))
  end

  test "should show catgroup" do
    get :show, id: @catgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catgroup
    assert_response :success
  end

  test "should update catgroup" do
    patch :update, id: @catgroup, catgroup: { cat_ids: @catgroup.cat_ids, image: @catgroup.image, name: @catgroup.name }
    assert_redirected_to catgroup_path(assigns(:catgroup))
  end

  test "should destroy catgroup" do
    assert_difference('Catgroup.count', -1) do
      delete :destroy, id: @catgroup
    end

    assert_redirected_to catgroups_path
  end
end
