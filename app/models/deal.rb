class Deal < ActiveRecord::Base
  self.table_name = "pb_deals"
  
  belongs_to :pb_company
  belongs_to :pb_product
  has_many :pb_saleorderitems
  
  has_many :pb_saleorders, :through => :pb_saleorderitems, foreign_key: "deal_id"
  
  has_many :agents, :through => :pb_saleorderitems, :source => :pb_member, foreign_key: "agent_username", primary_key: "username"
  
  belongs_to :pb_member
  
  def self.all_active
    self.all
  end
  
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
    @records = self.where(pb_member_id: user.id)
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<div class=\"\"><img src=\"#{item.pb_product.default_image}\" width=\"100\" /></div>",
              "<div class=\"\"><a href=\"#{item.pb_product.url}\" target=\"_blank\">#{item.pb_product.name}</a><br/>#{item.description}</div>",
              "<div class=\"\">#{item.display_price}</div>",
              "<div class=\"\">#{item.pb_product.price_unit}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.remain_items_count.to_s)}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.sold_items_count.to_s)}/#{ApplicationController.helpers.format_price(item.quantity.to_s)}</div>",
              "<div class=\"text-nowrap\">#{item.display_time}</div>",
              "<div class=\"\">#{item.display_statuses}</div>",
              "<div class=\"text-left text-nowrap\">#{item.show_link}<br />#{item.on_link}#{item.off_link}<br />#{item.edit_link}<br />#{item.destroy_link}</div>"
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
  
  def self.admin_deal_list(params, user)    
    @records = self.all.order("pb_deals.created_at DESC")
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<div class=\"\"><img src=\"#{item.pb_product.default_image}\" width=\"100\" /></div>",
              "<div class=\"\">#{item.show_link(item.pb_product.name)}<br/>#{item.description}<br />Thành viên: #{item.pb_member.display_name}</div>",
              "<div class=\"\">#{item.display_price}</div>",
              "<div class=\"\">#{item.pb_product.price_unit}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.remain_items_count.to_s)}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.sold_items_count.to_s)}/#{ApplicationController.helpers.format_price(item.quantity.to_s)}</div>",
              "<div class=\"text-nowrap\">#{item.display_time}</div>",
              "<div class=\"\">#{item.display_statuses}</div>",
              "<div class=\"text-left text-nowrap\">#{item.approve_link}<br />#{item.show_link}<br />#{item.edit_link}<br />#{item.destroy_link}</div>"
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
    str = []
    
    if status == "1"
      str << "<span class=\"text-nowrap text-success\">Đang chạy</span>"
    else
      str << "<span class=\"text-nowrap text-warning\">Đã tắt</span>"
    end
    
    if approved == 1
      str << "<span class=\"text-nowrap text-success\">Đã được duyệt</span>"
    else
      str << "<span class=\"text-nowrap text-warning\">Chưa được duyệt</span>"
    end
    
    return str.join("<br/>")
  end
  
  def self.agent_list(params, user)
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    #@deal = Deal.find(filters["deal_id"])
    @records = user.agents
    
    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.uniq.each do |item|
      row = [
              item.display_name,
              item.agent_sales_items_count,
              ApplicationController.helpers.format_price(item.agent_info({seller_id: user.id})[:total]),
              ApplicationController.helpers.format_price(item.agent_info({seller_id: user.id})[:deal_total]),
              ApplicationController.helpers.format_price(item.agent_gifts_count({seller_id: user.id})),
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
  
  
  
  def self.admin_agent_list(params, user)
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    #@deal = Deal.find(filters["deal_id"])
    @records = PbMember.all_agents
    
    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.uniq.each do |item|
      row = [
              item.display_name,
              item.agent_sales_items_count,
              ApplicationController.helpers.format_price(item.agent_info[:total]),
              ApplicationController.helpers.format_price(item.deal_income),
              ApplicationController.helpers.format_price(item.paid_amount),
              ApplicationController.helpers.format_price(item.remain_amount),
              "#{ApplicationController.helpers.format_price(item.remain_gift.to_i)}/#{ApplicationController.helpers.format_price(item.agent_gifts_count)}",
              "Chưa thanh toán",
              "<div class=\"text-left text-nowrap\">#{item.pay_agent_link}</div>"
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
  
  def deal_percent
    ((1 - price.to_f/pb_product.price.to_f)*100).round
  end
  
  def share_percent
    ((1 - share_amout.to_f/pb_product.price.to_f)*100).round
  end
  
  def agent_percent
    ((agent_amount.to_f/pb_product.price.to_f)*100).round
  end
  
  def self.customer_list(params, user)
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    #@deal = Deal.find(filters["deal_id"])
    @records = user.customers.joins(:pb_saleorders => :pb_saleorderitems).where("pb_saleorderitems.deal_id IS NOT NULL")
    
    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.uniq.each do |item|
      row = [
              item.display_name,
              item.deal_saleorderitems_count({seller_id: user.id}),
              ApplicationController.helpers.format_price(item.deal_saleorderitems_total({seller_id: user.id})),
              "<div class=\"text-nowrap\">#{item.last_bought({seller_id: user.id}).strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-nowrap\">#{item.first_bought({seller_id: user.id}).strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-left text-nowrap\">#{item.customer_history_link}</div>"
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
    price*(agent_price/100.0)
  end
  
  def display_price
    str = ["<div class=\"text-nowrap deal_label_col\">"]
    str << "<label>Giá deal/Giá gốc: </label>"
    str << "<div><span class=\"text-bold\">"+ApplicationController.helpers.format_price(price)+"</span>/<span class=\"text-bold\">"+ApplicationController.helpers.format_price(pb_product.price)+"</span></div>"
    if deal_type == 'discount'
      str << "<label>Giá cho cộng tác viên: </label>"
      str << "<div><span class=\"text-bold\">"+ApplicationController.helpers.format_price(agent_amount)+"</span> (giảm #{agent_price}%)</div>"
    else
      str << "<label>Điều kiện nhận quà: </label>"
      str << "<div>Bán <span class=\"text-bold\">"+ApplicationController.helpers.format_price(free_count)+"</span> tặng <span class=\"text-bold\">1</span></div>"
    end
    
      
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
  
  def on_link
    return "" if status == "1"
    
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-checkmark4\"></i> Bật deal".html_safe, {controller: "deals", action: "on", id: self.id}, class: "ajax_link")
  end
  
  def off_link
    return "" if status != "1"
    
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-close2\"></i> Tắt deal".html_safe, {controller: "deals", action: "off", id: self.id}, class: "ajax_link")
  end
  
  def approve_link
    return "" if approved == 1
    
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-checkmark4\"></i> Duyệt deal".html_safe, {controller: "deals", action: "approve", id: self.id}, data: { confirm: 'Bạn có chắc muốn duyệt DEAL này?' }, class: "ajax_link")
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
  
  def agent_orders
    pb_saleorders.joins(:pb_saleorderitems).where("pb_saleorderitems.agent_username IS NOT NULL").uniq
  end
  
  def self.select2_options(params, user)
    result = self.where(pb_member_id: user.id)
    
    if params[:type] == "agents"
      result = user.agents.map{|item| {text: item.display_name, value: item.id}}
    elsif params[:type] == "customers"
      result = user.customers.uniq.map{|item| {text: item.display_name, value: item.id}}
    else
      result = result.map{|item| {text: item.pb_product.name, value: item.id}}
    end
    
    return result
  end
  
  def self.corp_deals(params, user)    
    @records = user.corp_deals
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<div class=\"\"><img src=\"#{item.pb_product.default_image}\" width=\"100\" /></div>",
              "<div class=\"\"><a href=\"#{item.pb_product.url}\" target=\"_blank\">#{item.pb_product.name}</a><br/>#{item.description}</div>",
              "<div class=\"\">#{item.display_price}</div>",
              "<div class=\"\">#{item.pb_product.price_unit}</div>",
              "<div class=\"text-nowrap\">#{item.display_time}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(user.deal_items({deal_id: item.id}).sum(:quantity).to_s)}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(user.deal_income({deal_id: item.id}))}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(user.deal_gift_count({deal_id: item.id}))}</div>",
              "<div class=\"text-left text-nowrap\">#{user.corp_items_link(item.id)}</div>"
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
  
  def self.corp_members(params, user)    
    @records = user.corp_members
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<a href=\"#{item.pb_company.url}\" target=\"_blank\">#{item.pb_company.name}</a>",
              item.pb_company.display_address,
              item.pb_company.tel,
              item.pb_company.fax,
              item.pb_company.email,
              "<div class=\"\">#{ApplicationController.helpers.format_price(user.deal_items({seller_id: item.id}).sum(:quantity).to_s)}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(user.deal_income({seller_id: item.id}))}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(user.deal_gift_count({seller_id: item.id}))}</div>",
              "<div class=\"text-left text-nowrap\">#{user.corp_items_link(nil,nil,item.id)}</div>"
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
  
  def self.corp_customers(params, user)    
    @records = user.corp_customers.includes(:pb_saleorderitems).where("pb_saleorderitems.agent_username IS NOT NULL")
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "#{item.display_name}",
              item.display_address,
              (item.pb_memberfield.present? ? item.pb_memberfield.mobile : ""),
              item.email,
              "<div class=\"\">#{ApplicationController.helpers.format_price(user.deal_items({buyer_id: item.id}).sum(:quantity).to_s)}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(user.deal_income({buyer_id: item.id}))}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(user.deal_gift_count({buyer_id: item.id}))}</div>",
              "<div class=\"text-left text-nowrap\">#{user.corp_items_link(nil,item.id,nil)}</div>"
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
  
  def self.corp_non_member_customers(params, user)    
    @records = user.corp_saleorderitems.includes(:pb_saleorder).where(pb_saleorders: {buyer_id: 0})
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "#{item.pb_saleorder.fullname}",
              item.pb_saleorder.address,
              item.pb_saleorder.mobile,
              item.pb_saleorder.email,
              "<div class=\"\">#{item.diplay_total}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.agent_income)}</div>",
              "<div class=\"\">#{ApplicationController.helpers.format_price(item.agent_gift_count.to_i)}</div>",
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
  
  def update_top_industry
    topparent = pb_product.pb_industry.top_parent.id if pb_product.pb_industry.present?
    self.update_attribute(:top_industry_id, topparent)
  end
  
  def self.other_deals
    is = []
    top_industries = PbIndustry.all.where(level: 1).order("display_order")
    top_industries.each do |i|
      is << i.id if i.active_deals.count < 3
    end
    
    self.where(status: 1).where(approved: 1).where(top_industry_id: is)
  end
  
end
