class PbMembersController < ApplicationController
  load_and_authorize_resource :except => [:pending_order_count]
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: Deal.select2_options(params, @current_user) }
    end
  end
  
  def select2_options
    respond_to do |format|
      format.html
      format.json { render json: PbMember.select2_options(params, @current_user) }
    end
  end
  
  def deal_customers
    result = PbMember.deal_customers(params, @current_user)
    
    render json: result[:result]
  end
  
  def deal_agents
    result = PbMember.deal_agents(params, @current_user)
    
    render json: result[:result]
  end
  
  def pending_order_count
    user = PbMember.find(params[:user_id])
    render text: (!user.saleorders_alert_count.present? ? "" : "<span>"+user.saleorders_alert_count.to_s+"</span>")
  end
  
  def top_sellers
    respond_to do |format|
      format.html
      format.json {
        result = PbMember.top_sellers(params, @current_user)   
        render json: result[:result]
      }
    end
  end
  
  def top_buyers
    respond_to do |format|
      format.html
      format.json {
        result = PbMember.top_buyers(params, @current_user)   
        render json: result[:result]
      }
    end
  end
  
end