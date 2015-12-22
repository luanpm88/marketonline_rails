class PbSettingsController < ApplicationController
  load_and_authorize_resource
  
  def index
  end
  
  def datatable
    result = PbSetting.datatable(params, @current_user)
    
    render json: result[:result]
  end
  
  def save
    @setting = PbSetting.find(params[:id])
    @message = "Cấu hình đã được cập nhật."
    @setting.update_attribute(:valued, params[:value].strip)
    respond_to do |format|      
      format.html { render "/home/ajax_success", layout: nil }
      format.json { head :no_content }
    end
  end

  
end