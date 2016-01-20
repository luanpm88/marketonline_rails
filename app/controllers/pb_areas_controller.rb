class PbAreasController < ApplicationController
  load_and_authorize_resource
  def index
    respond_to do |format|
      format.html
      format.json {
        render json: PbArea.general_search(params, @current_user)
      }
    end
  end
  
  def display_tree
    render layout: nil
  end
end