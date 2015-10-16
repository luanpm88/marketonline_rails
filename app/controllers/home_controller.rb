class HomeController < ApplicationController
  def index
    @page_title = "<i class=\"icon-home position-left\"></i> Thông tin hoạt động".html_safe
  end
end