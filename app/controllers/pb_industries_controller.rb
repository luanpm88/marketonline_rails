class PbAreasController < ApplicationController
  load_and_authorize_resource
  def index
    respond_to do |format|
      format.html
      format.json {
        render json: PbIndustry.general_search(params, @current_user)
      }
    end
  end
end