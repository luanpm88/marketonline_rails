class PbSaleorderitemsController < ApplicationController
  load_and_authorize_resource
  
  def index
  end
  
  def datatable
    result = PbSaleorderitem.datatable(params, @current_user)
    
    render json: result[:result]
  end
  
end