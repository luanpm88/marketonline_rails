class PbSaleorder < ActiveRecord::Base
  self.primary_key = :id
  
  has_many :pb_saleorderitems, foreign_key: "saleorder_id"
  belongs_to :buyer, class_name: "PbMember", foreign_key: "buyer_id"
  belongs_to :seller, class_name: "PbMember", foreign_key: "seller_id"
  
  def self.datatable(params, user)
    @records = user.pb_sell_saleorders
    
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    @records = @records.order("pb_saleorders.created DESC")
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.uniq.each do |item|
      row = [
              "<div class=\"\">#{item.fullname}</div>",
              item.display_products,
              item.display_quantities,
              "<div class=\"text-nowrap text-right\">#{item.display_single_prices}</div>",
              "<div class=\"text-nowrap text-right\">#{item.display_prices}</div>",
              "<div class=\"text-nowrap\">#{item.ordered_time.to_datetime.strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-nowrap\">#{item.display_statuses}</div>",
              "<div class=\"text-left text-nowrap\">#{item.show_link}#{item.finish_link}#{item.cancel_link}</div>"
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
  
  def self.buy_orders(params, user)
    @records = user.pb_saleorders
    
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    @records = @records.order("pb_saleorders.created DESC")
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.uniq.each do |item|
      row = [
              "<div class=\"\">#{item.seller_name}</div>",
              item.display_products,
              item.display_quantities,
              "<div class=\"text-nowrap text-right\">#{item.display_single_prices}</div>",
              "<div class=\"text-nowrap text-right\">#{item.display_prices}</div>",
              "<div class=\"text-nowrap\">#{item.ordered_time.to_datetime.strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-nowrap\">#{item.display_statuses}</div>",
              "<div class=\"text-left text-nowrap\">#{item.show_link}</div>"
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
  
  def self.admin_list(params, user)
    @records = self.all
    
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    @records = @records.order("pb_saleorders.created DESC")
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.uniq.each do |item|
      row = [
              "<div class=\"\">#{item.fullname}</div>",
              item.display_products,
              item.display_quantities,
              "<div class=\"text-nowrap text-right\">#{item.display_single_prices}</div>",
              "<div class=\"text-nowrap text-right\">#{item.display_prices}</div>",
              "<div class=\"text-nowrap\">#{item.ordered_time.to_datetime.strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-nowrap\">#{item.display_statuses}</div>",
              "<div class=\"text-left text-nowrap\">#{item.show_link}#{item.finish_link}#{item.cancel_link}</div>"
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
  
  def display_statuses
    if finished == 1
      "<span class=\"text-success\">Hoàn tất</span>"
    elsif finished == -1
      "<span class=\"text-grey\">Đã hủy</span>"
    else
      "<span class=\"text-danger\">Mới đặt hàng</span>"
    end
    
  end
  
  def buyer_name
    return buyer.nil? ? "" : buyer.display_name
  end
  
  def seller_name
    return seller.nil? ? "" : (seller.pb_company.nil? ? "" : seller.pb_company.name)
  end
  
  def display_products
    names = pb_saleorderitems.uniq.map {|p| "<div title=\"#{p.pb_product_name}\" class=\"sale_product_name\"><a target=\"_blank\" href=\"#{p.pb_product.url}\">#{p.pb_product_name}</a><div>"}
    
    return names.join("<br>")
  end
  
  def display_quantities
    quantities = pb_saleorderitems.uniq.map {|p| p.quantity}
    
    return quantities.join("<br>")
  end
  
  def display_single_prices
    prices = pb_saleorderitems.uniq.map {|p| ApplicationController.helpers.format_price(p.price)}
    
    return prices.join("<br>")
  end
  
  def display_prices
    prices = pb_saleorderitems.uniq.map {|p| ApplicationController.helpers.format_price(p.total)}
    prices << ["<hr style=\"margin: 0\">#{ApplicationController.helpers.format_price(self.total)}"] if pb_saleorderitems.uniq.count > 1
    return prices.join("<br>")
  end
  
  def total
    total = 0.0
    pb_saleorderitems.each do |od|
      total += od.total
    end
    
    return total
  end
  
  def ordered_time
    Time.at(self.created).to_datetime
  end
  
  def show_link(title=nil)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    title = !title.nil? ? title : "<i class=\"icon-zoomin3\"></i> Xem chi tiết".html_safe
    link_helper.link_to(title, {controller: "pb_saleorders", action: "show", id: self.id})
  end
  
  def finish_link(title=nil)
    return "" if finished == 1 or finished == -1
    
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    title = !title.nil? ? title : "<i class=\"icon-checkmark\"></i> Hoàn tất".html_safe
    "<div>"+link_helper.link_to(title, {controller: "pb_saleorders", action: "finish", id: self.id}, class: "ajax_link text-success")+"</div>"
  end
  
  def cancel_link(title=nil)
    return "" if finished == 1 or finished == -1
    
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    title = !title.nil? ? title : "<i class=\"icon-close2\"></i> Hủy đơn hàng".html_safe
    "<div>"+link_helper.link_to(title, {controller: "pb_saleorders", action: "cancel", id: self.id}, class: "ajax_link text-grey")+"</div>"
  end
  
end