class AdsController < ApplicationController
  before_action :set_ad, only: [:image, :show, :edit, :update, :destroy]

  # GET /ads
  # GET /ads.json
  def index
    @page_title = "Danh sách quảng cáo"
    
    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @page_title = "Thêm quảng cáo"
    
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)

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
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
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
