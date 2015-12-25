class PbSaleorderitem < ActiveRecord::Base
  self.primary_key = :id
  
  belongs_to :deal
  belongs_to :pb_saleorder, foreign_key: "saleorder_id"
  belongs_to :pb_product, foreign_key: "product_id"
  
  def self.datatable(params, user)
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    @deal = Deal.find(filters["deal_id"])
    @records = @deal.pb_saleorderitems.includes(:pb_saleorder).order("pb_saleorders.created DESC")
    
    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              "<div class=\"text-nowrap\">#{item.buyer.display_name}</div>",
              item.pb_product.name,
              item.quantity,
              "<div class=\"text-nowrap text-right\">#{item.diplay_total}</div>",
              item.customer_type,
              "<div class=\"text-nowrap\">#{item.ordered_time.to_datetime.strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-nowrap\">#{item.display_status}</div>",
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
    "Mua trực tiếp"
  end
  
  def total
    total = price.to_f*quantity.to_f    
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