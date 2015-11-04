class PbProductsController < ApplicationController
  before_action :set_pb_product, only: [:show, :edit, :update, :destroy]
  
  def index
    respond_to do |format|
      format.html
      format.json {
        render json: PbProduct.general_search(params, @current_user)
      }
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.json {
        render json: {product: @pb_product, pictures: @pb_product.pictures, url: @pb_product.url}
      }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pb_product
      @pb_product = PbProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pb_product_params
      params.require(:ad_position).permit(:name)
    end
end