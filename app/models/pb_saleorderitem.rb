class PbSaleorderitem < ActiveRecord::Base
  self.primary_key = :id
  
  belongs_to :deal
  belongs_to :pb_saleorder, foreign_key: "saleorder_id"
  belongs_to :pb_product, foreign_key: "product_id"
  
  belongs_to :pb_member, foreign_key: "agent_username", primary_key: "username"
  
  belongs_to :agent, foreign_key: "agent_username", primary_key: "username", class_name: "PbMember"
  
  def self.datatable(params, user)
    @records = user.pb_sell_saleorderitems.includes(:pb_saleorder).where.not(deal_id: nil)
    
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end

    if filters["deal_id"].present?
      @records = @records.where(deal_id: filters["deal_id"])
    end
    
    if filters["agent_id"].present?      
      @records = @records.where(agent_username: PbMember.find(filters["agent_id"]).username)
    end
    
    if filters["customer_id"].present?
      @records = @records.where(pb_saleorders: {buyer_id: filters["customer_id"]})
    end

    #@records = @deal.pb_saleorderitems.includes(:pb_saleorder).order("pb_saleorders.created DESC")

    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    @records = @records.order("pb_saleorders.created DESC")
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<div class=\"text-nowrap\">#{item.pb_saleorder.fullname}</div>",
              item.pb_product.name,
              item.quantity,
              "<div class=\"text-nowrap text-right\">#{item.diplay_total}</div>",
              item.customer_type,
              "<div class=\"text-nowrap\">#{item.ordered_time.to_datetime.strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-nowrap\">#{item.pb_saleorder.display_statuses}</div>",
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
  
  def self.agent_corp_list(params, user)
    @records = self.includes(:pb_saleorder).where.not(deal_id: nil).where(agent_username: user.username)
    
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end

    if filters["deal_id"].present?
      @records = @records.where(deal_id: filters["deal_id"])
    end
    
    if filters["customer_id"].present?
      @records = @records.where(pb_saleorders: {buyer_id: filters["customer_id"]})
    end
    
    if filters["seller_id"].present?
      @records = @records.where(pb_saleorders: {seller_id: filters["seller_id"]})
    end

    #@records = @deal.pb_saleorderitems.includes(:pb_saleorder).order("pb_saleorders.created DESC")

    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    @records = @records.order("pb_saleorders.created DESC")
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<div class=\"text-nowrap\">#{item.pb_saleorder.fullname}</div>",
              item.pb_product.name,
              item.quantity,
              "<div class=\"text-nowrap text-right\">#{item.diplay_total}</div>",
              item.customer_type,
              "<div class=\"text-nowrap\">#{item.ordered_time.to_datetime.strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-nowrap\">#{item.pb_saleorder.display_statuses}</div>",
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

  
  def ordered_time
    Time.at(pb_saleorder.created).to_datetime
  end
  
  def customer_type
    if agent.nil?
      return "Mua trực tiếp"
    else
      return "<span class=\"text-nowrap\">Mua từ Cộng tác viên:</span><br >"+agent.display_name
    end
  end
  
  def pb_product_name
    return pb_product.nil? ? "<span class=\"text-grey\">Sản phẩm đã bị xóa!</span>" : pb_product.name
  end
  
  def pb_product_url
    return pb_product.nil? ? "" : pb_product.url
  end
  
  def total
    total = price.to_f*quantity.to_f    
  end
  
  def deal_total
    total = deal_price.to_f*quantity.to_f    
  end
  
  def agent_income
    deal_total.to_f*(deal.agent_price.to_f/100.0)
  end
  
  def diplay_total
    str = ["#{ApplicationController.helpers.format_price(total)}"]
    if quantity.to_f > 0
      str << "<br />(#{ApplicationController.helpers.format_price(price.to_f)}x#{quantity})"
    end
    return str.join("") 
  end
  
  def buyer
    pb_saleorder.buyer
  end
  
  def display_status
    "Đã đặt hàng"
  end
  
  def agent
    return nil if agent_username.nil?
    PbMember.where(username: agent_username).first
  end
  
end