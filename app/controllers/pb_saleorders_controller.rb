class PbSaleordersController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_pb_saleorder, only: [:cancel, :finish, :delete, :show, :edit, :update, :destroy]
  
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
  
  def admin_list
    respond_to do |format|
      format.html
      format.json {
        result = PbSaleorder.admin_list(params, @current_user)
        render json: result[:result]
      }
    end
  end
  
  def finish
    @message = "Đơn hàng đã hoàn tất."
    @pb_saleorder.update_attribute(:finished, 1) if @pb_saleorder.finished == 0
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  def cancel
    @message = "Đơn hàng đã bị hủy."
    @pb_saleorder.update_attribute(:finished, -1) if @pb_saleorder.finished == 0
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pb_saleorder
      @pb_saleorder = PbSaleorder.find(params[:id])
    end

end