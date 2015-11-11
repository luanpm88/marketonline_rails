class Ad < ActiveRecord::Base
  attr_accessor :product_name
  attr_accessor :banner_1
  attr_accessor :banner_2
  attr_accessor :banner_3
  attr_accessor :banner_4
  
  mount_uploader :image, AdUploader
  mount_uploader :image_2, AdUploader
  mount_uploader :image_3, AdUploader
  mount_uploader :image_4, AdUploader
  
  
  # validates :name, presence: true
  validates :ad_position_id, presence: true
  
  belongs_to :ad_position
  belongs_to :pb_member
  belongs_to :pb_product
  belongs_to :ad
  
  has_many :ad_clicks
  
  before_validation :update_ad_name
  before_validation :update_ad_image
  before_validation :update_ad_price
  after_save :update_product_name
  
  def max_budget=(new)
    self[:max_budget] = new.to_s.gsub(/\,/, '')
  end
  def days=(new)
    self[:days] = new.to_s.gsub(/\,/, '')
  end
  def price=(new)
    self[:price] = new.to_s.gsub(/\,/, '')
  end
  def display_price=(new)
    self[:display_price] = new.to_s.gsub(/\,/, '')
  end
  
  def main_ad_clicks
    ad_clicks.order("created_at DESC")
  end
  
  def click(request, session, user)
    ad_clicks.create(customer_code: session[:session_id], ip: request.remote_ip, pb_member_id: user.id)
  end
  
  
  def update_ad_name
    if product_name.present? and type_name == 'product'
      self.name = product_name
    end
  end
  
  def update_ad_image
    if banner_1 != "" and banner_1 != "upload" and !banner_1.include?("ads/image")
      self.remote_image_url = banner_1
    end
    if banner_2 != "" and banner_2 != "upload" and !banner_2.include?("ads/image")
      self.remote_image_2_url = banner_2
    end
    if banner_3 != "" and banner_3 != "upload" and !banner_3.include?("ads/image")
      self.remote_image_3_url = banner_3
    end
    if banner_4 != "" and banner_4 != "upload" and !banner_4.include?("ads/image")
      self.remote_image_4_url = banner_4
    end   
  end
  
  def update_ad_price
    if payment_type == "per_day"
      self.price = ad_position.day_price
    elsif payment_type == "per_click"
      self.price = max_budget
    end    
  end
  
  def update_product_name
    if type_name == 'product' and pb_product.present?
      pb_product.update_attribute(:name, name)
    end
  end
  
  def self.datatable(params, user)    
    @records = self.joins(:ad_position).all
    
    if user.role != "admin"
      @records = @records.where(pb_member_id: user.id)
    end
    
    
    order = "ads.created_at DESC"
    if !params["order"].nil?
      case params["order"]["0"]["column"]
      when "1"
        order = "ads.name"
      when "2"
        order = "ad_positions.title"
      when "4"
        order = "ads.created_at"
      end
      order += " "+params["order"]["0"]["dir"]
    end
    @records = @records.order(order) if !order.nil?
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("LOWER(ads.name) LIKE ? OR LOWER(ad_positions.title) LIKE ?", "%#{q}%", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|      
      row = [
              item.image_link,
              item.name,
              "<div class=\"text-center\">#{item.ad_position.display_name}</div>",                     
              "<div class=\"text-center\">#{item.display_valid_time}</div>",
              "<div class=\"text-center\">#{(item.pb_member.display_name if !item.pb_member.nil?)}</div>",
              "<div class=\"text-center\">#{item.click_count.to_s}</div>",
              "<div class=\"text-center\">#{item.display_status}</div>",
              "<div class=\"text-right\"><ul class=\"icons-list\">"+
                  "<li class=\"dropup\">"+
                      "<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"><i class=\"icon-menu7\"></i></a>"+
                      "<ul class=\"dropdown-menu dropdown-menu-right\">"+
                          "<li>#{item.statistic_link}</li>"+
                          "<li>#{item.edit_link}</li>"+
                          "<li>#{item.destroy_link}</li>"+
                      "</ul>"+
                  "</li>"+
              "</ul></div>"
            ]
      data << row      
    end
    
    result = {
              "drawn" => params[:drawn],
              "recordsTotal" => total,
              "recordsFiltered" => total
    }
    result["data"] = data
    
    return {result: result}
  end
  
  def display_valid_time
    s = start_at.nil? ? "" : start_at.strftime("%d-%b-%Y")
    e = end_at.nil? ? "" : end_at.strftime("%d-%b-%Y")
    "Từ ngày:<br /><strong>#{s}</strong><br />Đến ngày:<br /><strong>#{e}</strong>"
  end
  
  def click_count
    ad_clicks.count
  end
  
  # IMAGE 1
  def image_path(version = nil)
    if self.image_url.nil?
      return "public/img/avatar.jpg"
    elsif !version.nil?
      return self.image_url(version)
    else
      return self.image_url
    end
  end
  
  def image_src(version = nil, display="inline")
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.url_for(controller: "ads", action: "image", id: self.id, type: version, display: display)
  end
  
  def display_image(version = nil)
    "<img src='#{image_src(version)}' />".html_safe
  end
  
  def image_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    link_helper.link_to(display_image(:square), image_src(:banner, "html"), class: "fancybox.ajax fancybox ad_link", title: name)
  end
  
  # IMAGE 2
  def image_2_path(version = nil)
    if self.image_2_url.nil?
      return "public/img/avatar.jpg"
    elsif !version.nil?
      return self.image_2_url(version)
    else
      return self.image_2_url
    end
  end
  
  def image_2_src(version = nil)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.url_for(controller: "ads", action: "image_2", id: self.id, type: version)
  end
  
  def display_image_2(version = nil)
    "<img src='#{image_2_src(version)}' />".html_safe
  end
  
  def image_2_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to(display_image_2(:square), image_src(:banner), class: "fancybox.image fancybox ad_link", title: name)
  end
  
  
  # IMAGE 3
  def image_3_path(version = nil)
    if self.image_3_url.nil?
      return "public/img/avatar.jpg"
    elsif !version.nil?
      return self.image_3_url(version)
    else
      return self.image_3_url
    end
  end
  
  def image_3_src(version = nil)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.url_for(controller: "ads", action: "image_3", id: self.id, type: version)
  end
  
  def display_image_3(version = nil)
    "<img src='#{image_3_src(version)}' />".html_safe
  end
  
  def image_3_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to(display_image_3(:square), image_src(:banner), class: "fancybox.image fancybox ad_link", title: name)
  end
  
  
  # IMAGE 4
  def image_4_path(version = nil)
    if self.image_4_url.nil?
      return "public/img/avatar.jpg"
    elsif !version.nil?
      return self.image_4_url(version)
    else
      return self.image_4_url
    end
  end
  
  def image_4_src(version = nil)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.url_for(controller: "ads", action: "image_4", id: self.id, type: version)
  end
  
  def display_image_4(version = nil)
    "<img src='#{image_4_src(version)}' />".html_safe
  end
  
  def image_4_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to(display_image_4(:square), image_src(:banner), class: "fancybox.image fancybox ad_link", title: name)
  end
  
  def destroy_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-bin\"></i> Xóa".html_safe, {controller: "ads", action: "delete", id: self.id}, method: :delete, data: { confirm: 'Bạn có chắc muốn xóa quảng cáo này?' }, class: "ajax_link")
  end
  
  def edit_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-pencil\"></i> Sửa".html_safe, {controller: "ads", action: "edit", id: self.id})
  end
  
  def statistic_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-statistics\"></i> Xem thống kê".html_safe, {controller: "ads", action: "show", id: self.id})
  end
  
  def add_status(status_name)
    statuses = statuses << status_name if !statuses.include?(status_name)
    update_statuses(statuses)
  end
  
  def statuses
    return [] if status.nil?
    status.to_s.split("][").map {|s| s.gsub("[","").gsub("]","")}
  end
  
  def update_statuses(arr)
    self.update_attribute(:status, "["+arr.join("][")+"]")
  end
  
  def self.get_by_ad_position(pos)
    pos = self.includes(:ad_position).where(ad_positions: {name: pos})
  end
  
  def self.type_name_options
    [
      ["Hình ảnh & Liên kết","image"],
      ["Sản phẩm/Dịch vụ","product"],
      ["Thương mại","trade"],
      ["Thương hiệu","company"],
      ["Tuyển dụng","employer"],
      ["Ứng viên","employee"],
      ["Trường học","school"],
      ["Lớp học","class"]
    ]
  end
  
  def clicks
    ad_clicks
  end
  
  def redirect_url
    if type_name == 'product'
      # http://test.marketonline.vn/san-pham/19550/ten-san-pham-chi-tiet-mau-can-co-cac-hang-muc-sau
      pb_product.url
    else
      url
    end
    
  end
  
  def self.display_chart_days(from,to)
    result = (from..to).map { |d| d.strftime("%d/%m") }
    return result
  end
  
  def chart_values(type=nil,from,to)
    arr = []
    (from..to).each do |d|
      records = ad_clicks.where("created_at >= ? AND created_at <= ?", d.beginning_of_day, d.end_of_day)
      records = records.where(pb_member_id: nil) if type == "guest"
      records = records.where.not(pb_member_id: nil) if type == "user"
      
      arr << records.count
    end
    
    return arr
  end
  
  def current_step
    return 0 if id.nil?
    return 1
  end
  
  def total_price
    if payment_type == "per_click"
      max_budget
    elsif payment_type == "per_day"
      price.to_f*days
    end    
  end
  
  def ad_code
    id.to_s # "MKOVN901#{((self.id*6789)%888+100)}874"
  end
  
  def get_checkout_url(request)
    return_url = "http://"+request.host+ActionController::Base.helpers.url_for(controller: "ads", action: "get_nganluong_checkout_return", id: self.id)
    email = "service@marketonline.vn"
    note = self.name
    amount = self.total_price
    
    url = (`php lib/nganluong.php get_checkout_url "#{return_url}" "#{email}" "#{note}" "#{ad_code}" "#{amount}"`).strip
    
    return url[1..-1]
  end
  
  def check_nganluong_payment
    client = Savon::Client.new(wsdl:"https://www.nganluong.vn/public_api.php?wsdl")
    # client.operations
    merchant_id = "39955"
    param = '<ORDERS><TOTAL>1</TOTAL><ORDER><ORDER_CODE>21</ORDER_CODE><PAYMENT_ID>17992700</PAYMENT_ID></ORDER></ORDERS>'
    checksum =  Digest::MD5.hexdigest(merchant_id + param + 'marketonlinebmn@#$')
    response = client.call(:check_order, message: {merchant_id: merchant_id, param: param, checksum: checksum})
  end
  
  def paid?
    !nganluong_return_url.nil?
  end
  
  def display_status
    if paid?
      "<span class=\"label bg-blue\">Đang chạy</span>"
    else
      "<span class=\"label bg-grey-400\">Đang soạn</span>"
    end    
  end
end
