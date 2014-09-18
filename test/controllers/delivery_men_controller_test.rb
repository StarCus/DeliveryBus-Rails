require 'test_helper'

class DeliveryMenControllerTest < ActionController::TestCase
  setup do
    @delivery_man = delivery_men(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_men)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_man" do
    assert_difference('DeliveryMan.count') do
      post :create, delivery_man: {  }
    end

    assert_redirected_to delivery_man_path(assigns(:delivery_man))
  end

  test "should show delivery_man" do
    get :show, id: @delivery_man
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery_man
    assert_response :success
  end

  test "should update delivery_man" do
    patch :update, id: @delivery_man, delivery_man: {  }
    assert_redirected_to delivery_man_path(assigns(:delivery_man))
  end

  test "should destroy delivery_man" do
    assert_difference('DeliveryMan.count', -1) do
      delete :destroy, id: @delivery_man
    end

    assert_redirected_to delivery_men_path
  end
end
