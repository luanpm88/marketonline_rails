class PbMembersController < ApplicationController
  load_and_authorize_resource
  
  def deal_customers
    result = PbMember.deal_customers(params, @current_user)
    
    render json: result[:result]
  end
end