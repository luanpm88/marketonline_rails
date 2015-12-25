class Deal < ActiveRecord::Base
  self.table_name = "pb_deals"
  
  belongs_to :pb_company
  belongs_to :pb_product
  has_many :pb_saleorderitems
  
  has_many :pb_saleorders, :through => :pb_saleorderitems, foreign_key: "deal_id"
  
  def price=(new)
    self[:price] = new.to_s.gsub(/\,/, '')
  end
  def agent_price=(new)
    self[:agent_price] = new.to_s.gsub(/\,/, '')
  end
  def share_price=(new)
    self[:share_price] = new.to_s.gsub(/\,/, '')
  end
  
  def self.datatable(params, user)    
    @records = self.all
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<div class=\"\"><img src=\"#{item.pb_product.default_image}\" width=\"100\" /></div>",
              "<div class=\"\">#{item.show_link(item.pb_product.name)}<br/>#{item.description}</div>",
              "<div class=\"\">#{item.display_price}</div>",
              "<div class=\"\">#{item.pb_product.price_unit}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.remain_items_count.to_s)}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.sold_items_count.to_s)}/#{ApplicationController.helpers.format_price(item.quantity.to_s)}</div>",
              "<div class=\"text-nowrap\">#{item.display_time}</div>",
              "<div class=\"\"></div>",
              "<div class=\"text-left text-nowrap\">#{item.show_link}<br />#{item.edit_link}<br />#{item.destroy_link}</div>"
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
  
  def share_amout
    price*(1.0-share_price/100.0)
  end
  
  def agent_amount
    price*(1.0-agent_price/100.0)
  end
  
  def display_price
    str = ["<div class=\"text-nowrap deal_label_col\">"]
    str << "<label>Giá deal/Giá gốc: </label>"
    str << "<div><span class=\"text-bold\">"+ApplicationController.helpers.format_price(price)+"</span>/<span class=\"text-bold\">"+ApplicationController.helpers.format_price(pb_product.price)+"</span></div>"
    str << "<label>Giá cho cộng tác viên: </label>"
    str << "<div><span class=\"text-bold\">"+ApplicationController.helpers.format_price(agent_amount)+"</span> (giảm #{agent_price}%)</div>"
    str << "<label>Giá người được giới thiệu: </label>"
    str << "<div><span class=\"text-bold\">"+ApplicationController.helpers.format_price(share_amout)+"</span> (giảm #{share_price}%)</div>"
    str << "</div>"
    
    return str.join("")
  end
  
  def display_time
    str = ["<div class=\"text-nowrap deal_label_col\">"]
    str << "<label>Bắt đầu ngày: </label>"
    str << "<div><span class=\"text-bold\">"+start_at.strftime("%d-%m-%Y")+"</span></div>"
    str << "<label>Kết thúc ngày: </label>"
    str << "<div><span class=\"text-bold\">"+end_at.strftime("%d-%m-%Y")+"</span></div>"
    str << "<label>Còn lại: </label>"
    str << "<div><span class=\"text-bold\">"+(end_at.to_date - Date.today).to_i.to_s+"</span> ngày</div>"
    str << "</div>"
    
    return str.join("")
  end
  
  def sold_items_count
    pb_saleorderitems.sum(:quantity)
  end
  
  def remain_items_count
    quantity - sold_items_count
  end
  
  def destroy_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-bin\"></i> Xóa".html_safe, {controller: "deals", action: "delete", id: self.id}, method: :delete, data: { confirm: 'Bạn có chắc muốn xóa DEAL này?' }, class: "ajax_link")
  end
  def edit_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-pencil\"></i> Sửa".html_safe, {controller: "deals", action: "edit", id: self.id})
  end
  def show_link(title=nil)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    title = !title.nil? ? title : "<i class=\"icon-zoomin3\"></i> Xem chi tiết".html_safe
    link_helper.link_to(title, {controller: "deals", action: "show", id: self.id})
  end
  
  def buyers
    PbMember.joins(:pb_saleorders => :pb_saleorderitems).where(pb_saleorderitems: {deal_id: self.id}).uniq
  end
  
  def pb_salesorderitems
    pb_salesorderitems.where.not(agent_username: nil)
  end
  
end
