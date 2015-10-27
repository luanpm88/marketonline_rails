class AdClicksController < ApplicationController
  before_action :set_ad_click, only: [:show, :edit, :update, :destroy]

  # GET /ad_clicks
  # GET /ad_clicks.json
  def index
    @ad_clicks = AdClick.all
  end

  # GET /ad_clicks/1
  # GET /ad_clicks/1.json
  def show
  end

  # GET /ad_clicks/new
  def new
    @ad_click = AdClick.new
  end

  # GET /ad_clicks/1/edit
  def edit
  end

  # POST /ad_clicks
  # POST /ad_clicks.json
  def create
    @ad_click = AdClick.new(ad_click_params)

    respond_to do |format|
      if @ad_click.save
        format.html { redirect_to @ad_click, notice: 'Ad click was successfully created.' }
        format.json { render :show, status: :created, location: @ad_click }
      else
        format.html { render :new }
        format.json { render json: @ad_click.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_clicks/1
  # PATCH/PUT /ad_clicks/1.json
  def update
    respond_to do |format|
      if @ad_click.update(ad_click_params)
        format.html { redirect_to @ad_click, notice: 'Ad click was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad_click }
      else
        format.html { render :edit }
        format.json { render json: @ad_click.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_clicks/1
  # DELETE /ad_clicks/1.json
  def destroy
    @ad_click.destroy
    respond_to do |format|
      format.html { redirect_to ad_clicks_url, notice: 'Ad click was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def datatable
    result = AdClick.datatable(params)
    
    render json: result[:result]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_click
      @ad_click = AdClick.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_click_params
      params.require(:ad_click).permit(:ad_id, :customer_code, :ip)
    end
end
