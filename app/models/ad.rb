class Ad < ActiveRecord::Base
  attr_accessor :product_name
  attr_accessor :banner
  
  mount_uploader :image, AdUploader
  
  # validates :name, presence: true
  validates :ad_position_id, presence: true
  
  belongs_to :ad_position
  belongs_to :pb_member
  belongs_to :pb_product
  
  has_many :ad_clicks
  
  before_validation :update_ad_name
  before_validation :update_ad_image
  after_save :update_product_name
  
  def click(request, session)
    ad_clicks.create(customer_code: session[:session_id], ip: request.remote_ip)
  end
  
  def update_ad_name
    if product_name.present? and type_name == 'product'
      self.name = product_name
    end
  end
  
  def update_ad_image
    if banner != "" and banner != "upload"
      self.remote_image_url = banner
    end    
  end
  
  def update_product_name
    if type_name == 'product' and pb_product.present?
      pb_product.update_attribute(:name, name)
    end
  end
  
  def self.datatable(params)    
    @records = self.joins(:ad_position).all
    
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
              "<div class=\"text-center\">#{item.created_at.strftime("%d-%m-%Y")}</div>",
              "<div class=\"text-center\">#{(item.pb_member.display_name if !item.pb_member.nil?)}</div>",
              "<div class=\"text-center\"></div>",
              "<div class=\"text-right\"><ul class=\"icons-list\">"+
                  "<li class=\"dropup\">"+
                      "<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"><i class=\"icon-menu7\"></i></a>"+
                      "<ul class=\"dropdown-menu dropdown-menu-right\">"+
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
  
  def image_path(version = nil)
    if self.image_url.nil?
      return "public/img/avatar.jpg"
    elsif !version.nil?
      return self.image_url(version)
    else
      return self.image_url
    end
  end
  
  def image_src(version = nil)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.url_for(controller: "ads", action: "image", id: self.id, type: version)
  end
  
  def display_image(version = nil)
    "<img src='#{image_src(version)}' />".html_safe
  end
  
  def image_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to(display_image(:square), image_src(:banner), class: "fancybox.image fancybox ad_link", title: name)
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
      "/san-pham/#{self.pb_product_id.to_s}/"+pb_product.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub!(/\W/,'').gsub("xaaaaax","-").gsub(/\-+/,"-")
    else
      url
    end
    
  end
  
end
