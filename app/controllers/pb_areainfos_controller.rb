class PbAreainfosController < ApplicationController
  load_and_authorize_resource
  
  def index
  end
  
  def datatable
    result = PbAreainfo.datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def intros
    #code
  end
  
  # DELETE /ads/1
  # DELETE /ads/1.json
  def delete
    @ad = PbAreainfo.find(params[:id])
    @message = "Thông tin vị trí đã được xóa."
    @ad.destroy
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end
  
end