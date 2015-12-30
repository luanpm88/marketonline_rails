require 'test_helper'

class AgentPaymentsControllerTest < ActionController::TestCase
  setup do
    @agent_payment = agent_payments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agent_payments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agent_payment" do
    assert_difference('AgentPayment.count') do
      post :create, agent_payment: { amount: @agent_payment.amount, note: @agent_payment.note, pb_member_id: @agent_payment.pb_member_id, user_id: @agent_payment.user_id }
    end

    assert_redirected_to agent_payment_path(assigns(:agent_payment))
  end

  test "should show agent_payment" do
    get :show, id: @agent_payment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @agent_payment
    assert_response :success
  end

  test "should update agent_payment" do
    patch :update, id: @agent_payment, agent_payment: { amount: @agent_payment.amount, note: @agent_payment.note, pb_member_id: @agent_payment.pb_member_id, user_id: @agent_payment.user_id }
    assert_redirected_to agent_payment_path(assigns(:agent_payment))
  end

  test "should destroy agent_payment" do
    assert_difference('AgentPayment.count', -1) do
      delete :destroy, id: @agent_payment
    end

    assert_redirected_to agent_payments_path
  end
end
