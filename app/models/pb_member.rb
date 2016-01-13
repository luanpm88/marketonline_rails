class PbMember < ActiveRecord::Base  
  self.primary_key = :id
  
  has_one :pb_memberfield, foreign_key: "member_id"
  has_one :pb_company, foreign_key: "member_id"
  has_many :pb_products, foreign_key: "member_id"
  has_many :pb_saleorders, foreign_key: "buyer_id"
  has_many :pb_saleorderitems, :through => :pb_saleorders
  has_many :customers, -> { uniq }, :through => :pb_sell_saleorders, :source => :buyer
  
  has_many :pb_sell_saleorders, foreign_key: "seller_id", class_name: "PbSaleorder"
  has_many :pb_sell_saleorderitems, -> { uniq }, :through => :pb_sell_saleorders, :source => :pb_saleorderitems, class_name: "PbSaleorderitem"
  
  has_many :agent_orderitems, foreign_key: "agent_username", primary_key: "username", class_name: "PbSaleorderitem"
  
  has_many :agents, -> { uniq }, :through => :pb_sell_saleorderitems, :source => :pb_member, foreign_key: "agent_username", primary_key: "username"
  
  has_many :deals
  
  has_many :corp_saleorderitems, -> { uniq }, class_name: "PbSaleorderitem", primary_key: "username", foreign_key: "agent_username"
  has_many :corp_saleorders, -> { uniq }, :source => :pb_saleorder, :through => :corp_saleorderitems
  
  has_many :corp_members, -> { uniq }, :through => :corp_saleorders, :source => :seller
  
  has_many :corp_customers, -> { uniq }, :through => :corp_saleorders, :source => :buyer
  
  has_many :agent_payments
  
  def display_name
    return username if !pb_memberfield.present? or !pb_memberfield.first_name.present? and !pb_memberfield.last_name.present?
    pb_memberfield.first_name+" "+pb_memberfield.last_name
  end
  
  def self.all_agents
    self.joins(:agent_orderitems).where("pb_saleorderitems.id IS NOT NULL")
  end
  
  def corp_deals
    Deal.joins(:pb_saleorderitems).where(pb_saleorderitems: {agent_username: self.username})
  end
  
  def deal_income(filter={})
    total = 0.0
    deal_items(filter).each do |item|
      total += item.agent_income
    end
    return total
  end
  
  def deal_gift_count(filter={})    
    deals = {}
    deal_items(filter).each do |item|
      deals[item.deal.id] = 0.0 if deals[item.deal.id].nil?
      deals[item.deal.id] += item.agent_gift_count
    end
    
    total = 0.0
    deals.each do |row|
      total += row[1].to_i
    end
    
    return total.to_i
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
    corp_customers.uniq.count + corp_saleorderitems.includes(:pb_saleorder).where(pb_saleorders: {buyer_id: 0}).count
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
              ApplicationController.helpers.format_price(item.agent_info({deal_id: @deal})[:deal_total]),
              ApplicationController.helpers.format_price(item.agent_gifts_count({deal_id: @deal})),
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
  
  def agent_gifts_count(filters={})
    count = 0.0
    agent_gifts(filters).each do |item|
      count += item[:gift_count]
    end
    return count
  end
  
  def agent_gifts_deals(filters={})
    arr = []
    agent_gifts(filters).each do |item|
      arr << item[:deal]
    end
    return arr
  end
  
  def display_agent_gifts(filters={})
    arr = []
    agent_gifts(filters).each do |item|
      arr << "<span class='text-nowrap'>#{item[:deal].pb_product.name}: <strong>#{remain_gift(item[:deal].id)}</strong></span>"
    end
    return arr.join("<br />").html_safe
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
  
  def gift_count_by_deal(deal)
    return "" if deal.deal_type != 'gift'
    (agent_sales_items_count_by_deal(deal)/deal.free_count).to_i
  end
  
  def agent_info(filters = {})
    orderitems = agent_orderitems
    
    if filters[:seller_id].present?
      orderitems = orderitems.includes(:pb_saleorder).where(pb_saleorders: {seller_id: filters[:seller_id]})
    end
    if filters[:deal_id].present?
      @deal = Deal.find(filters[:deal_id])
      orderitems = orderitems.where(deal_id: filters[:deal_id])
    end    
    
    # statistic
    result = {total: 0.0, deal_total: 0.0, gifts: {}}
    orderitems.each do |item|
      result[:total] += item.total
      result[:deal_total] += item.deal_total if item.deal.present? and item.deal.deal_type == "discount"
      if item.deal.present? and item.deal.deal_type == "gift"
        result[:gifts][item.deal.id] = {total: 0.0, free_count: item.deal.free_count}      
        result[:gifts][item.deal.id][:total] += item.quantity
      end
    end    
    
    return result
  end
  
  def agent_gifts(filters={})
    arr = []
    agent_info(filters)[:gifts].each do |row|
      arr << {deal: Deal.find(row[0]), total: row[1][:total], free_count: row[1][:free_count], gift_count: (row[1][:total]/row[1][:free_count]).to_i}
    end
    return arr
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
  
  def self.saleorders_alert_count
    result = PbSaleorder.where(finished: 0).where("created > 1451635200").count

    return (result == 0 ? "" : result)
  end
  
  def saleorders_alert_count
    result = pb_sell_saleorders.where(finished: 0).count
    
    return (result == 0 ? "" : result)
  end
  
  def display_address
    return "" if pb_memberfield.present?
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
    agent_payments.where(payment_type: 'discount').sum(:amount)
  end
  
  def remain_amount
    deal_income - paid_amount
  end
  
  def paid_gift(deal_id=nil)
    result = agent_payments.where(payment_type: 'gift')
    if deal_id.present?
      result = result.where(deal_id: deal_id)
    end    
    return result.sum(:amount)
  end
  
  def remain_gift(deal_id=nil)
    deal_gift_count({deal_id: nil}) - paid_gift(deal_id)
  end
  
  def self.top_sellers(params, user)
    @records = self.joins(:pb_company).where("pb_companies.id IS NOT NULL").where("pb_members.total_sales IS NOT NULL AND pb_members.total_sales > 0")
    
    ## FILTERS
    #filters = {}
    #params["filters"].split('&').each do |row|
    #  filters[row.split("=")[0]] = row.split("=")[1]
    #end
    
    if !params["order"].nil?
      case params["order"]["0"]["column"]
      when "1"
        order = "pb_members.total_sold_products"
      when "3"
        order = "pb_members.real_total_sales"
      when "4"
        order = "pb_members.total_buyers"
      else
        order = "pb_members.total_sales"
      end
      order += " "+params["order"]["0"]["dir"]
    else
      order = "pb_members.total_sales DESC"
    end
    
    @records = @records.order(order)
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.uniq.each do |item|
      row = [
              "<a target=\"_blank\" href=\"#{item.pb_company.url}\">#{item.pb_company.shop_name}</a><br />#{item.pb_company.name}<br />#{item.display_name}<br />#{item.username}",
              item.total_sold_items_count,
              ApplicationController.helpers.format_price(item.total_sales).to_s+"<br>".html_safe+item.order_list_link,
              ApplicationController.helpers.format_price(item.real_total_sales).to_s,
              item.customer_count,
              item.last_sold,
              item.first_sold,
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
  
  def update_total_sales
    total = 0.0
    pb_sell_saleorderitems.each do |soi|
      total += soi.total
    end
    self.update_attribute(:total_sales, total)
    self.update_attribute(:total_buyers, customer_count)
    self.update_attribute(:real_total_sales, real_total_sales)
    self.update_attribute(:total_sold_products, total_sold_items_count)
    
    total = 0.0
    pb_saleorderitems.each do |soi|
      total += soi.total
    end
    self.update_attribute(:total_bought, total)
    self.update_attribute(:total_sellers, seller_count)
    self.update_attribute(:real_total_bought, real_total_bought)
    self.update_attribute(:total_bought_products, total_bought_items_count)
  end
  
  def real_total_sales
    total = 0.0
    pb_sell_saleorderitems.each do |soi|
      total += soi.total if soi.pb_saleorder.finished == 1
    end
    return total
  end
  
  def real_total_bought
    total = 0.0
    pb_saleorderitems.each do |soi|
      total += soi.total if soi.pb_saleorder.finished == 1
    end
    return total
  end
  
  def total_sold_items_count
    pb_sell_saleorderitems.sum(:quantity)
  end
  
  def total_bought_items_count
    pb_saleorderitems.sum(:quantity)
  end
  
  def customer_count
    pb_sell_saleorders.map(&:buyer_id).uniq.count + pb_sell_saleorders.where(buyer_id: nil).map(&:fullname).uniq.count
  end
  
  def seller_count
    pb_saleorders.map(&:seller_id).uniq.count
  end
  
  def first_sold
    item = pb_sell_saleorders.order("created").first
    return item.nil? ? "" : Time.at(item.created).to_datetime.strftime("%d-%m-%Y, %H:%I %p")
  end
  
  def last_sold
    item = pb_sell_saleorders.order("created DESC").first
    return item.nil? ? "" : Time.at(item.created).to_datetime.strftime("%d-%m-%Y, %H:%I %p")
  end
  
  def order_list_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("Xem chi tiết".html_safe, {controller: "pb_saleorders", action: "admin_list", shop_name: pb_company.name}, target: "_blank")
  end
  
  def self.top_buyers(params, user)
    @records = self.where("total_bought > 0")
    
    ## FILTERS
    #filters = {}
    #params["filters"].split('&').each do |row|
    #  filters[row.split("=")[0]] = row.split("=")[1]
    #end
    
    if !params["order"].nil?
      case params["order"]["0"]["column"]
      when "1"
        order = "pb_members.total_bought_products"
      when "3"
        order = "pb_members.real_total_bought"
      when "4"
        order = "pb_members.total_sellers"
      else
        order = "pb_members.total_bought"
      end
      order += " "+params["order"]["0"]["dir"]
    else
      order = "pb_members.total_bought DESC"
    end
    
    @records = @records.order(order)
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.uniq.each do |item|
      row = [
              "#{item.display_name}<br />#{item.username}",
              item.total_bought_items_count,
              ApplicationController.helpers.format_price(item.total_bought).to_s+"<br>".html_safe+item.bought_order_list_link,
              ApplicationController.helpers.format_price(item.real_total_bought).to_s,
              item.seller_count,
              item.last_bought,
              item.first_bought,
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
  
  def first_bought
    item = pb_saleorders.order("created").first
    return item.nil? ? "" : Time.at(item.created).to_datetime.strftime("%d-%m-%Y, %H:%I %p")
  end
  
  def last_bought
    item = pb_saleorders.order("created DESC").first
    return item.nil? ? "" : Time.at(item.created).to_datetime.strftime("%d-%m-%Y, %H:%I %p")
  end
  
  def bought_order_list_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("Xem chi tiết".html_safe, {controller: "pb_saleorders", action: "admin_list", buyer: self.username}, target: "_blank")
  end
  
end
