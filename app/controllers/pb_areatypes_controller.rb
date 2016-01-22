class PbAreatypesController < ApplicationController
  before_action :set_pb_areatype, only: [:delete_image, :delete, :show, :edit, :update, :destroy]
  
  def index
    authorize! :manage, PbAreatype
    
    respond_to do |format|
      format.html
      format.json {
        result = PbAreatype.datatable(params, @current_user)    
        render json: result[:result]
      }
    end
  end
  
  def delete_image
    authorize! :manager, PbAreatype
    
    @pb_areatype.remove_image! if params[:pos] == ""
    @pb_areatype.remove_image_2! if params[:pos] == "_2"
    @pb_areatype.remove_image_3! if params[:pos] == "_3"
    @pb_areatype.remove_image_4! if params[:pos] == "_4"
    
    @pb_areatype.save
    @message = "Đã xóa ảnh."
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  # GET /deals/1/edit
  def edit
    authorize! :manage, PbAreatype

  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    authorize! :update, PbAreatype

    respond_to do |format|
      if @pb_areatype.update(pb_areatype_params)
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
    def set_pb_areatype
      @pb_areatype = PbAreatype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pb_areatype_params
      params.require(:pb_areatype).permit(:image, :image_2, :image_3, :image_4)
    end
  
end