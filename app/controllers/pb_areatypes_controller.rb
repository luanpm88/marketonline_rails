class PbAreatypesController < ApplicationController
  before_action :set_pb_areatype, only: [:delete, :show, :edit, :update, :destroy]
  
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
        format.html { redirect_to pb_areatypes_path, notice: 'Thông tin đã được lưu thành công!' }
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