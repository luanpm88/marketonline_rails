class AdPosition < ActiveRecord::Base
  validates :name, presence: true
  has_many :ads
  
  def self.get(pos)
    self.where(name: pos).first
  end
  
  def active_ads
    ads
  end
  
  def width=(new)
    self[:width] = new.to_s.gsub(/\,/, '')
  end
  def height=(new)
    self[:height] = new.to_s.gsub(/\,/, '')
  end
  def click_price=(new)
    self[:click_price] = new.to_s.gsub(/\,/, '')
  end
  def day_price=(new)
    self[:day_price] = new.to_s.gsub(/\,/, '')
  end
  
  def self.datatable(params)    
    @records = self.all
    
    order = "ad_positions.name"
    if !params["order"].nil?
      case params["order"]["0"]["column"]
      when "0"
        order = "ad_positions.name"
      when "1"
        order = "ad_positions.title"
      else
        order = "ad_positions.created_at"
      end
      order += " "+params["order"]["0"]["dir"]
    end
    @records = @records.order(order) if !order.nil?
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("LOWER(ad_positions.name) LIKE ? OR LOWER(ad_positions.title) LIKE ?", "%#{q}%", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|      
      row = [
              item.name,
              item.title,
              "<div class=\"text-center\">#{item.display_size}</div>",              
              "<div class=\"text-center\">#{item.created_at.strftime("%d-%m-%Y")}</div>",              
              "<div class=\"text-right\">#{item.display_prices}</div>",
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
  
  def display_prices
    str = []
    str << "<div class=\"text-nowrap\">Lượt nhấn: <strong>#{ApplicationController.helpers.format_price(click_price)} VNĐ</strong></div>"
    str << "<div class=\"text-nowrap\">Ngày: <strong>#{ApplicationController.helpers.format_price(day_price)} VNĐ</strong></div>"
    
    return str.join("")
  end
  
  def display_size
    "#{width.to_s} x #{height.to_s}"
  end
  
  def display_name
    "<span class=\"text-nowrap\">#{title}</span><br />#{display_size}".html_safe
  end

  def display_name_option
    "#{title} (#{display_size})"
  end
  
  def destroy_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-bin\"></i> Xóa".html_safe, {controller: "ad_positions", action: "delete", id: self.id}, method: :delete, data: { confirm: 'Are you sure?' })
  end
  
  def edit_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-pencil\"></i> Sửa".html_safe, {controller: "ad_positions", action: "edit", id: self.id})
  end
  
  def get_remaining_days(type=nil)
    recent_ad = active_ads.order("end_at").where("end_at >= ?", Time.now).first
    if type == "date"
      return "" if recent_ad.nil?
      {time: recent_ad.end_at.strftime("%d/%m/%Y"), pos: self}
    elsif type == "day"
      return "" if recent_ad.nil?
      (recent_ad.end_at.to_date - Date.today).to_s
    else
      recent_ad.nil? ? Date.today : recent_ad.end_at
    end
  end
  
end
