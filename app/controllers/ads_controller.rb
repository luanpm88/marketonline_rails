class AdsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  
  before_action :set_ad, only: [:get_nganluong_checkout_return, :chart, :click, :delete, :show, :edit, :update, :destroy]

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @begin_date = Date.today - 5
    @end_date = Date.today + 5
  end

  # GET /ads/new
  def new
    @ad = Ad.new
    @ad.start_at = Time.now + 3.days
    @ad.end_at = @ad.start_at + 1.month
    if params[:pos].present?
      @ad.ad_position = AdPosition.get(params[:pos])
    end    
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
    result = Ad.datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def image
    if params[:id].present?
      @ad = Ad.find(params[:id])
      if @ad.image.nil?
        file_name = "public/img/no_img.jpg"
      else
        file_name = @ad.image_path(params[:type])
      end
    else
      file_name = "public/img/no_img.jpg"
    end
    
    if params[:display] == "html"
      if @ad.present?
        if @ad.ad_position.style_name == "4_images_group"
          render "/ads/preview", layout: nil
        elsif @ad.ad_position.style_name == "3_images_group"
          render "/ads/preview", layout: nil
        else
          render text: "<img src=\"#{@ad.image_url(params[:type])}\" />"
        end
      else
        render text: "<img src=\"#{root_path}img/no_img.jpg\" />"
      end
    else
      send_file file_name, :disposition => 'inline'
    end   
  end
  
  def image_2
    if params[:id].present?
      @ad = Ad.find(params[:id])
      if @ad.image.nil?
        send_file "public/img/no_img.jpg", :disposition => 'inline'
      else
        send_file @ad.image_2_path(params[:type]), :disposition => 'inline'
      end
    else
      send_file "public/img/no_img.jpg", :disposition => 'inline'
    end
  end
  
  def image_3
    if params[:id].present?
      @ad = Ad.find(params[:id])
      if @ad.image.nil?
        send_file "public/img/no_img.jpg", :disposition => 'inline'
      else
        send_file @ad.image_3_path(params[:type]), :disposition => 'inline'
      end
    else
      send_file "public/img/no_img.jpg", :disposition => 'inline'
    end
  end
  
  def image_4
    if params[:id].present?
      @ad = Ad.find(params[:id])
      if @ad.image.nil?
        send_file "public/img/no_img.jpg", :disposition => 'inline'
      else
        send_file @ad.image_4_path(params[:type]), :disposition => 'inline'
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
    @ad.click(request, session, @current_user)
    redirect_to @ad.redirect_url
  end
  
  def chart
    from = params[:daterange].split(" - ")[0].to_date
    to = params[:daterange].split(" - ")[1].to_date
    render json: {days: Ad.display_chart_days(from,to), value_1: @ad.chart_values("guest",from,to).to_json, value_2: @ad.chart_values("user",from,to).to_json}
  end
  
  def get_nganluong_checkout_return
    @ad.update_attribute(:nganluong_return_url, request.original_url)
    render nothing: true
  end
  
  def enable
    @message = "Quảng cáo <strong>#{@ad.name}</strong> đã được kích hoạt."
    @ad.update_attribute(:active, 1)
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
  def disable
    @message = "Quảng cáo <strong>#{@ad.name}</strong> đã được hủy kích hoạt."
    @ad.update_attribute(:active, 0)
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
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
      params.require(:ad).permit(:start_at, :end_at, :display_price_unit, :display_price, :days, :payment_type, :max_budget, :banner_1, :banner_2, :banner_3, :banner_4, :type_name, :product_name, :pb_product_id, :name, :description, :description_2, :ad_position_id, :url, :image, :image_2, :image_3, :image_4, :user_id, :status)
    end
end
