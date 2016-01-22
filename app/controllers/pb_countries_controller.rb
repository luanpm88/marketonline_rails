class PbCountriesController < ApplicationController
  before_action :set_pb_country, only: [:delete_image, :delete, :show, :edit, :update, :destroy]
  
  def index
    authorize! :manage, PbCountry
    
    respond_to do |format|
      format.html
      format.json {
        result = PbAreatype.datatable(params, @current_user)    
        render json: result[:result]
      }
    end
  end
  
  def delete_image
    authorize! :manager, PbCountry
    
    @pb_country.remove_image! if params[:pos] == ""
    @pb_country.remove_image_2! if params[:pos] == "_2"
    @pb_country.remove_image_3! if params[:pos] == "_3"
    @pb_country.remove_image_4! if params[:pos] == "_4"
    
    @pb_country.save
    @message = "Đã xóa ảnh."
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  # GET /deals/1/edit
  def edit
    authorize! :manage, PbCountry

  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    authorize! :update, PbCountry

    respond_to do |format|
      if @pb_country.update(pb_country_params)
        format.html { redirect_to pb_areas_path, notice: 'Thông tin đã được lưu thành công!' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pb_country
      @pb_country = PbCountry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pb_country_params
      params.require(:pb_country).permit(:image, :image_2, :image_3, :image_4)
    end
  
end