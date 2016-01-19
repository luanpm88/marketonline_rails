class CatgroupsController < ApplicationController
  before_action :set_catgroup, only: [:show, :edit, :update, :destroy]

  # GET /catgroups
  # GET /catgroups.json
  def index
    @catgroups = Catgroup.ordered
  end

  # GET /catgroups/1
  # GET /catgroups/1.json
  def show
    
    render layout: nil
  end
  
  def display_menu
    render layout: nil
  end

  # GET /catgroups/new
  def new
    @catgroup = Catgroup.new
  end

  # GET /catgroups/1/edit
  def edit
  end

  # POST /catgroups
  # POST /catgroups.json
  def create
    @catgroup = Catgroup.new(catgroup_params)

    respond_to do |format|
      if @catgroup.save
        @catgroup.update_related_cat_ids
        format.html { redirect_to catgroups_path, notice: 'Catgroup was successfully created.' }
        format.json { render :show, status: :created, location: @catgroup }
      else
        format.html { render :new }
        format.json { render json: @catgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catgroups/1
  # PATCH/PUT /catgroups/1.json
  def update
    respond_to do |format|
      if @catgroup.update(catgroup_params)
        @catgroup.update_related_cat_ids
        format.html { redirect_to catgroups_path, notice: 'Catgroup was successfully updated.' }
        format.json { render :show, status: :ok, location: @catgroup }
      else
        format.html { render :edit }
        format.json { render json: @catgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catgroups/1
  # DELETE /catgroups/1.json
  def destroy
    @catgroup.destroy
    respond_to do |format|
      format.html { redirect_to catgroups_url, notice: 'Catgroup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catgroup
      @catgroup = Catgroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catgroup_params
      params.require(:catgroup).permit(:display_order, :name, :image, :cat_ids => [])
    end
end
