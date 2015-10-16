class AdPositionsController < ApplicationController
  before_action :set_ad_position, only: [:show, :edit, :update, :destroy]

  # GET /ad_positions
  # GET /ad_positions.json
  def index
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
        format.html { redirect_to @ad_position, notice: 'Ad position was successfully created.' }
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
        format.html { redirect_to @ad_position, notice: 'Ad position was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_position
      @ad_position = AdPosition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_position_params
      params.require(:ad_position).permit(:name, :description)
    end
end
