class DealsController < ApplicationController
  # load_and_authorize_resource
  before_action :set_deal, only: [:delete, :show, :edit, :update, :destroy]

  # GET /deals
  # GET /deals.json
  def index
    @deals = Deal.all
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
  end

  # GET /deals/new
  def new
    @deal = Deal.new
  end

  # GET /deals/1/edit
  def edit
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(deal_params)

    respond_to do |format|
      if @deal.save
        format.html { redirect_to deals_path, notice: 'DEAL đã được tạo thành công!' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    respond_to do |format|
      if @deal.update(deal_params)
        format.html { redirect_to deals_path, notice: 'DEAL đã được sửa thành công!' }
        format.json { render :show, status: :ok, location: @deal }
      else
        format.html { render :edit }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def datatable
    result = Deal.datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def agent_list
    respond_to do |format|
      format.html
      format.json {
        result = Deal.agent_list(params, @current_user)    
        render json: result[:result]
      }
    end    
  end
  
  def customer_list
    respond_to do |format|
      format.html
      format.json {
        result = Deal.customer_list(params, @current_user)    
        render json: result[:result]
      }
    end    
  end

  def delete
    @message = "DEAL sản phẩm <strong>#{@deal.pb_product.name}</strong> đã được xóa."
    @deal.destroy
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end

  def show_product_details
    @product = PbProduct.find(params[:product_id])
    
    render layout: nil
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_params
      params.require(:deal).permit(:agent_price, :share_price, :pb_product_id, :pb_company_id, :start_at, :end_at, :quantity, :price, :status, :description)
    end

end
