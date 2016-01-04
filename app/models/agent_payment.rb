class AgentPayment < ActiveRecord::Base
  belongs_to :pb_member
  belongs_to :user, class_name: "PbMember", foreign_key: "user_id"
  
  def amount=(new)
    self[:amount] = new.to_s.gsub(/\,/, '')
  end
  
  def self.user_payments(params, user)
    # FILTERS
    filters = {}
    params["filters"].split('&').each do |row|
      filters[row.split("=")[0]] = row.split("=")[1]
    end
    
    #@deal = Deal.find(filters["deal_id"])
    @records = AgentPayment.all.where(pb_member_id: user.id)
    
    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("pb_saleorders.name LIKE ?", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.uniq.each do |item|
      row = [
              "<span class=\"text-nowrap\">#{item.created_at.strftime("%d-%m-%Y, %H:%I %p")}</span>",
              item.display_payment_type,
              item.note,              
              ApplicationController.helpers.format_price(item.amount)
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
  
  def display_payment_type
    payment_type == 'dicount' ? "Gửi tiền" : "Tặng sản phẩm"
  end
  
end
