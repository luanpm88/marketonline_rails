class PbMember < ActiveRecord::Base  
  self.primary_key = :id
  
  has_one :pb_memberfield, foreign_key: "member_id"
  has_one :pb_company, foreign_key: "member_id"
  has_many :pb_products, foreign_key: "member_id"
  has_many :pb_saleorders, foreign_key: "buyer_id"
  has_many :pb_saleorderitems, :through => :pb_saleorders
  has_many :customers, -> { uniq }, :through => :pb_saleorders, :source => :buyer, foreign_key: "buyer_id", primary_key: "id"
  
  has_many :pb_sell_saleorders, foreign_key: "seller_id", class_name: "PbSaleorder"
  has_many :pb_sell_saleorderitems, :through => :pb_sell_saleorders, :source => :pb_saleorderitems, class_name: "PbSaleorderitem"
  
  has_many :agent_orderitems, foreign_key: "agent_username", primary_key: "username", class_name: "PbSaleorderitem"
  
  has_many :agents, -> { uniq }, :through => :pb_sell_saleorderitems, :source => :pb_member, foreign_key: "agent_username", primary_key: "username"
  
  has_many :deals
  
  has_many :corp_saleorderitems, -> { uniq }, class_name: "PbSaleorderitem", primary_key: "username", foreign_key: "agent_username"
  has_many :corp_saleorders, -> { uniq }, :source => :pb_saleorder, :through => :corp_saleorderitems
  
  has_many :corp_members, -> { uniq }, :through => :corp_saleorders, :source => :seller
  
  has_many :corp_customers, -> { uniq }, :through => :corp_saleorders, :source => :seller
  
  has_many :agent_payments
  
  def display_name
    pb_memberfield.first_name+" "+pb_memberfield.last_name
  end
  
  def self.all_agents
    self.joins(:agent_orderitems).where("pb_saleorderitems.id IS NOT NULL")
  end
  
  def corp_deals
    Deal.joins(:pb_saleorderitems).where(pb_saleorderitems: {agent_username: self.username})
  end
  
  def deal_income(filter={})
    deal_items(filter).sum("deal_price*quantity")
  end
  
  def deal_items(filter={})
    result = corp_saleorderitems
    if filter[:deal_id].present?
      result = result.where(deal_id: filter[:deal_id])
    end
    if filter[:seller_id].present?
      result = result.includes(:pb_saleorder).where(pb_saleorders: {seller_id: filter[:seller_id]})
    end
    if filter[:buyer_id].present?
      result = result.includes(:pb_saleorder).where(pb_saleorders: {buyer_id: filter[:buyer_id]})
    end
    return result
  end
  
  def deal_items_count
    corp_saleorderitems.sum("quantity")
  end
  
  def deal_customers_count
    corp_customers.uniq.count
  end
  
  def self.deal_customers(params, user)
    # FILTERS
    filters = {}
    if params["filters"].present?
      params["filters"].split('&').each do |row|
        filters[row.split("=")[0]] = row.split("=")[1]
      end
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
    result = {total: 0.0, deal_total: 0.0}
    orderitems.each do |item|
      result[:total] += item.total
      result[:deal_total] += item.deal_total
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
    link_helper.link_to(title, {controller: "deals", action: "item_list", agent_id: self.id})
  end
  
  
  def customer_history_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    title = "<i class=\"icon-history\"></i> Lịch sử mua hàng".html_safe
    link_helper.link_to(title, {controller: "deals", action: "item_list", customer_id: self.id})
  end
  
  
  def saleorders_alert_count
    pb_sell_saleorders.where(finished: 0).count
  end
  
  def display_address
    pb_memberfield.address+", "+pb_memberfield.pb_area.full_name
  end
  
  def corp_items_link(deal_id=nil,buyer_id=nil,seller_id=nil)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-history\"></i> Xem lịch sử cộng tác".html_safe, {controller: "deals", action: "agent_page", deal_id: deal_id, buyer_id: buyer_id, seller_id: seller_id})
  end
  
  def agent_payment_status
    #code
  end
  
  def pay_agent_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-cash\"></i> Thanh toán".html_safe, {controller: "agent_payments", action: "new", member_id: self.id})
  end
  
  def paid_amount
    agent_payments.sum(:amount)
  end
  
  def remain_amount
    agent_info[:total] - paid_amount
  end
  
end