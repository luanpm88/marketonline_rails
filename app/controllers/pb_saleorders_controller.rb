class PbSaleordersController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_pb_saleorder, only: [:delete, :show, :edit, :update, :destroy]
  
  def show
  end
  
  def index
  end
  
  def datatable
    result = PbSaleorder.datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def buy_orders
    respond_to do |format|
      format.html
      format.json {
        result = PbSaleorder.buy_orders(params, @current_user)
        render json: result[:result]
      }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pb_saleorder
      @pb_saleorder = PbSaleorder.find(params[:id])
    end

end