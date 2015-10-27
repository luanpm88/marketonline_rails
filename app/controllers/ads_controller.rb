class AdsController < ApplicationController
  before_action :set_ad, only: [:click, :delete, :show, :edit, :update, :destroy]

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
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
      format.html { redirect_to ads_path, notice: 'Quảng cáo đã được xóa.' }
      format.json { head :no_content }
    end
  end
  
  def datatable
    result = Ad.datatable(params)
    
    render json: result[:result]
  end
  
  def image
    if params[:id].present?
      @ad = Ad.find(params[:id])
      if @ad.image.nil?
        send_file "public/img/no_img.jpg", :disposition => 'inline'
      else
        send_file @ad.image_path(params[:type]), :disposition => 'inline'
      end
    else
      send_file "public/img/no_img.jpg", :disposition => 'inline'
    end
  end
  
  # DELETE /ads/1
  # DELETE /ads/1.json
  def delete
    @message = "Quảng cáo <strong>#{@ad.name}</strong> đã được xóa."
    @ad.destroy
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  def click
    @ad.click(request, session)
    redirect_to @ad.redirect_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:banner, :type_name, :product_name, :pb_product_id, :name, :description, :ad_position_id, :url, :image, :user_id, :status)
    end
end
