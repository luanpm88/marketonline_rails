class PbAreasController < ApplicationController
  
  before_action :set_pb_area, only: [:delete, :show, :edit, :update, :destroy]
  
  def index
    respond_to do |format|
      format.html
      format.json {
        render json: PbArea.general_search(params, @current_user)
      }
    end
  end
  
  def display_tree
    
    render layout: nil
  end
  
  def index
    authorize! :manage, PbArea
    
    respond_to do |format|
      format.html
      format.json {
        result = PbArea.datatable(params, @current_user)    
        render json: result[:result]
      }
    end
  end
  
  # GET /deals/1/edit
  def edit
    authorize! :manage, PbArea

  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    authorize! :update, @pb_area

    respond_to do |format|
      if @pb_area.update(pb_area_params)
        format.html { redirect_to pb_areas_path, notice: 'Thông tin đã được lưu thành công!' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def announce_intro_box
    @item = PbAreatype.find(params[:areatype_id]) if params[:areatype_id].present?
    @item = PbArea.find(params[:area_id]) if params[:area_id].present?
    
    render layout: nil
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pb_area
      @pb_area = PbArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pb_area_params
      params.require(:pb_area).permit(:image, :image_2, :image_3, :image_4, :type_name, :area_ids, :start_at, :end_at, :title, :area_id, :member_id, :content, :status, :created, :type_name, :area_moderator)
    end
  
end