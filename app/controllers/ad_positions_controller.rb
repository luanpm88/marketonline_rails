class AdPositionsController < ApplicationController
  before_action :set_ad_position, only: [:get_values, :preview_box, :show, :edit, :update, :destroy]

  # GET /ad_positions
  # GET /ad_positions.json
  def index
    @page_title = "<i class=\"icon-stack2 position-left\"></i> Vị trí đặt quảng cáo".html_safe

    @ad_positions = AdPosition.all
  end

  # GET /ad_positions/1
  # GET /ad_positions/1.json
  def show
  end

  # GET /ad_positions/new
  def new
    @ad_position = AdPosition.new
  end

  # GET /ad_positions/1/edit
  def edit
  end

  # POST /ad_positions
  # POST /ad_positions.json
  def create
    @ad_position = AdPosition.new(ad_position_params)

    respond_to do |format|
      if @ad_position.save
        format.html { redirect_to ad_positions_path, notice: 'Ad position was successfully created.' }
        format.json { render :show, status: :created, location: @ad_position }
      else
        format.html { render :new }
        format.json { render json: @ad_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_positions/1
  # PATCH/PUT /ad_positions/1.json
  def update
    respond_to do |format|
      if @ad_position.update(ad_position_params)
        format.html { redirect_to ad_positions_path, notice: 'Ad position was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad_position }
      else
        format.html { render :edit }
        format.json { render json: @ad_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_positions/1
  # DELETE /ad_positions/1.json
  def destroy
    @ad_position.destroy
    respond_to do |format|
      format.html { redirect_to ad_positions_url, notice: 'Ad position was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def datatable
    result = AdPosition.datatable(params)
    
    render json: result[:result]
  end

  def iframe_home_top_banner
    @pos_1 = AdPosition.get("home_top_banner_1")
    @pos_2 = AdPosition.get("home_top_banner_2")
    @pos_3 = AdPosition.get("home_top_banner_3")

    render layout: "ad_frame"
  end
  
  def preview_box
    render layout: nil
  end
  
  def get_values
    start_date = "#{@ad_position.get_remaining_days.time}"
    end_date = ""
    render json: {pos: @ad_position, start_date: start_date, end_date: end_date}
  end
  
  def get_remaining_time
    @ad_position = AdPosition.get(params[:pos])
    render json: @ad_position.get_remaining_days("date")
  end
  
  def iframe_home_feature_4_images_box
    @pos = AdPosition.get(params[:pos])
    @ad = @pos.active_ads.first
    render layout: "ad_frame"
  end
  
  def iframe_home_feature_3_images_box
    @pos = AdPosition.get(params[:pos])
    @ad = @pos.active_ads.first
    render layout: "ad_frame"
  end
  
  def iframe_6_items_list
    @pos = AdPosition.get(params[:pos])
    render layout: "ad_frame"
  end
  
  def iframe_3_wide_banners
    @pos = AdPosition.get(params[:pos])
    render layout: "ad_frame"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_position
      @ad_position = AdPosition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_position_params
      params.require(:ad_position).permit(:style_name, :title, :width, :height, :day_price, :click_price, :name, :description)
    end
end