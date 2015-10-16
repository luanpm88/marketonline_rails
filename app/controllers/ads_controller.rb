class AdsController < ApplicationController
  before_action :set_ad, only: [:delete, :image, :show, :edit, :update, :destroy]

  # GET /ads
  # GET /ads.json
  def index
    @page_title = "<i class=\"icon-stack2 position-left\"></i> Quản lý quảng cáo".html_safe
    
    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @page_title = "<i class=\"icon-stack2 position-left\"></i> Thêm quảng cáo".html_safe
    
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
    @page_title = "<i class=\"icon-stack2 position-left\"></i> Sửa quảng cáo".html_safe
    
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)
    @ad.pb_member = PbSession.get_current_user(cookies)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to ads_path, notice: 'Đã thêm quảng cáo thành công.' }
        format.json { render :show, status: :created, location: @ad }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        @ad.image.recreate_versions!
        
        format.html { redirect_to ads_path, notice: 'Đã cập nhật quảng cáo thành công.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_path, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def datatable
    result = Ad.datatable(params)
    
    render json: result[:result]
  end
  
  def image
    send_file @ad.image_path(params[:type]), :disposition => 'inline'
  end
  
  # DELETE /ads/1
  # DELETE /ads/1.json
  def delete
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_path, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:name, :description, :ad_position_id, :url, :image, :user_id, :status)
    end
end
