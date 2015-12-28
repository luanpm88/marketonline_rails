class PbMember < ActiveRecord::Base  
  self.primary_key = :id
  
  has_one :pb_memberfield, foreign_key: "member_id"
  has_one :pb_company, foreign_key: "member_id"
  has_many :pb_products, foreign_key: "member_id"
  has_many :pb_saleorders, foreign_key: "buyer_id"
  has_many :pb_saleorderitems, :through => :pb_saleorders
  has_many :customers, :through => :pb_saleorders, :source => :buyer, foreign_key: "buyer_id", primary_key: "id"
  
  has_many :pb_sell_saleorders, foreign_key: "buyer_id", class_name: "PbSaleorder"
  has_many :pb_sell_saleorderitems, :through => :pb_sell_saleorders, :source => :pb_saleorderitems, class_name: "PbSaleorderitem"
  
  has_many :agent_orderitems, foreign_key: "agent_username", primary_key: "username", class_name: "PbSaleorderitem"
  
  has_many :agents, :through => :pb_sell_saleorderitems, :source => :pb_member, foreign_key: "agent_username", primary_key: "username"
  
  def display_name
    pb_memberfield.first_name+" "+pb_memberfield.last_name
  end
  
  def self.deal_customers(params, user)
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    @deal = Deal.find(filters["deal_id"])
    @records = @deal.buyers
    
    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              item.display_name,
              item.deal_saleorderitems_count({deal_id: @deal.id}),
              ApplicationController.helpers.format_price(item.deal_saleorderitems_total({deal_id: @deal.id})),
              "<div class=\"text-nowrap\">#{item.last_bought({deal_id: @deal.id}).strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-nowrap\">#{item.first_bought({deal_id: @deal.id}).strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "Đã mua hàng"
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
  
  def self.deal_agents(params, user)
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    @deal = Deal.find(filters["deal_id"])
    @records = @deal.agents
    
    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              item.display_name,
              item.agent_sales_items_count_by_deal(@deal),
              ApplicationController.helpers.format_price(item.agent_info({deal_id: @deal})[:total]),              
              ApplicationController.helpers.format_price(item.agent_income({deal_id: @deal})), 
              "Chưa thanh toán: <br>0/#{ApplicationController.helpers.format_price(item.agent_income({deal_id: @deal}))}",
              "<div class=\"text-left text-nowrap\">#{item.agent_history_link}</div>"
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
  
  def all_pb_products
    pb_products.where(status: 1).where(valid_status: 1).where(show: 1).where(state: 1)
  end
  
  def image
    if !pb_company.nil? && pb_company.picture.present?
      "http://marketonline.vn/attachment/#{pb_company.picture}"
    elsif photo.present?
      "http://marketonline.vn/attachment/#{photo}"
    else
      "/app/assets/images/placeholder.jpg"
    end
  end
  
  def shop_url
    pb_company.nil? ? nil : "/#{pb_company.cache_spacename}"
  end
  
  def referrer
    (referrer_id.present? and referrer_id > 0) ? PbMember.find(referrer_id) : PbMember.first
  end
  
  def deal_saleorderitems(filters={})
    items = pb_saleorderitems
    
    if filters[:deal_id].present?
      items = items.where(deal_id: filters[:deal_id])
    end
    if filters[:seller_id].present?
      items = items.includes(:pb_saleorder).where(pb_saleorders: {seller_id: filters[:seller_id]})
    end
    
    return items
  end
  
  def deal_saleorderitems_count(filters={})
    deal_saleorderitems(filters).sum(:quantity)
  end
  
  def deal_saleorderitems_total(filters={})
    total = 0.0
    deal_saleorderitems(filters).each do |item|
      total += item.quantity.to_f*item.price.to_f
    end
    
    return total
  end
  
  def orders(filters={})
    items = pb_saleorders
    if filters[:deal_id].present?
        items = items.joins(:pb_saleorderitems).where(pb_saleorderitems: {deal_id: filters[:deal_id]})
    end
    if filters[:seller_id].present?
        items = items.where(seller_id: filters[:seller_id])
    end
    return items
  end
  
  def last_bought(filters={})
    Time.at(orders(filters).order("created DESC").first.created).to_datetime
  end
  
  def first_bought(filters={})
    Time.at(orders(filters).order("created").first.created).to_datetime
  end
  
  def agent_sales_items_count
    agent_orderitems.sum(:quantity)
  end
  
  def agent_sales_items_count_by_deal(deal)
    agent_orderitems.where(deal_id: deal.id).sum(:quantity)
  end
  
  def agent_info(filters = {})
    orderitems = agent_orderitems
    
    if filters[:seller_id].present?
      orderitems = orderitems.includes(:pb_saleorder).where(pb_saleorders: {seller_id: filters[:seller_id]})
    end
    if filters[:deal_id].present?
      orderitems = orderitems.where(deal_id: filters[:deal_id])
    end    
    
    # statistic
    result = {total: 0.0}
    orderitems.each do |item|
      result[:total] += item.total
    end
    
    return result
  end 
  
  def agent_income(filters = {})
    agent_info(filters)[:total]
  end
  
  def agent_history_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    title = "<i class=\"icon-history\"></i> Lịch sử bán hàng".html_safe
    link_helper.link_to(title, {controller: "pb_members", action: "index", id: self.id})
  end
  
end