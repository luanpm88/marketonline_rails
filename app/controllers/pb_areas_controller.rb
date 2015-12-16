class PbAreasController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json {
        render json: PbArea.general_search(params, @current_user)
      }
    end
  end
end