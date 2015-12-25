class HomeController < ApplicationController
  load_and_authorize_resource :class => false
  
  def index
    @page_title = "<i class=\"icon-home position-left\"></i> Thông tin hoạt động".html_safe
  end
  
end