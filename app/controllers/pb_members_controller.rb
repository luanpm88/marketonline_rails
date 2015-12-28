class PbMembersController < ApplicationController
  load_and_authorize_resource
  
  def deal_customers
    result = PbMember.deal_customers(params, @current_user)
    
    render json: result[:result]
  end
  
  def deal_agents
    result = PbMember.deal_agents(params, @current_user)
    
    render json: result[:result]
  end
end