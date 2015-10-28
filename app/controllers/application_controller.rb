class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :app_variable

  def app_variable
    @current_user = PbSession.get_current_user(cookies)
    if !["home_top_banner_frame","click"].include?(params[:action])
      redirect_to "http://test.marketonline.vn/logging.php?return_page=#{Rack::Utils.escape(root_path(:only_path => false))}" if @current_user.nil?
    end
  end
  
end