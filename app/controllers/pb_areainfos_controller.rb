class PbAreainfosController < ApplicationController
  #load_and_authorize_resource
  
  # load_and_authorize_resource
  before_action :set_pb_areainfo, only: [:delete, :show, :edit, :update, :destroy]
  
  def index
  
  end
  
  def datatable
    authorize! :read, PbAreainfo
    
    result = PbAreainfo.datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def member_datatable
    authorize! :read, PbAreainfo
    
    result = PbAreainfo.member_datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def intros
    #code
  end
  
  # DELETE /ads/1
  # DELETE /ads/1.json
  def delete    
    @ad = PbAreainfo.find(params[:id])    
    authorize! :delete, @ad
    
    @message = "Thông tin vị trí đã được xóa."
    @ad.destroy
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  def approve
    @ad = PbAreainfo.find(params[:id])    
    authorize! :approve, @ad
    
    @message = "Thông tin vị trí đã được duyệt."
    @ad.update_attribute(:status, 1)
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  def unapprove
    @ad = PbAreainfo.find(params[:id])    
    authorize! :unapprove, @ad
    
    @message = "Thông tin vị trí đã được bỏ duyệt."
    @ad.update_attribute(:status, 0)
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  def member_intros
    authorize! :read, PbAreainfo
    
  end
  
  def member_announces
    authorize! :read, PbAreainfo
    
  end
  
  # GET /deals/1
  # GET /deals/1.json
  def show
    authorize! :read, @pb_areainfo
  end

  # GET /deals/new
  def new
    authorize! :create, PbAreainfo
    
    @pb_areainfo = PbAreainfo.new(type_name: params[:type_name])
    @pb_areainfo.start_at = Date.today
    @pb_areainfo.end_at = Date.today + 1.month
  end

  # GET /deals/1/edit
  def edit
    authorize! :update, @pb_areainfo
  end

  # POST /deals
  # POST /deals.json
  def create
    authorize! :create, PbAreainfo
  
    @pb_areainfo = PbAreainfo.new(pb_areainfo_params)
    @pb_areainfo.area_id = 0
    @pb_areainfo.area_moderator = 0
    @pb_areainfo.created = Time.now
    @pb_areainfo.member_id = @current_user.id
    respond_to do |format|
      if @pb_areainfo.save
        format.html { redirect_to pb_areainfos_path(type_name: @pb_areainfo.type_name), notice: 'Thông tin đã được tạo thành công!' }
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
    authorize! :update, @pb_areainfo

    respond_to do |format|
      if @pb_areainfo.update(pb_areainfo_params)
        format.html { redirect_to pb_areainfos_path(type_name: @pb_areainfo.type_name), notice: 'Thông tin đã được lưu thành công!' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pb_areainfo
      @pb_areainfo = PbAreainfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pb_areainfo_params
      params.require(:pb_areainfo).permit(:type_name, :area_ids, :start_at, :end_at, :title, :area_id, :member_id, :content, :status, :created, :type_name, :area_moderator)
    end
  
end