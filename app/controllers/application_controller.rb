class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :app_variable
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "http://marketonline.vn/logging.php?return_page=#{Rack::Utils.escape("http://marketonline.vn:3000"+request.fullpath)}"
  end
  
  def app_variable
    @current_user = current_user
  end
  
  def current_user
    PbSession.get_current_user(cookies)
  end
  
end