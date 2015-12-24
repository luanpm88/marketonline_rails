class PbMember < ActiveRecord::Base  
  self.primary_key = :id
  
  has_one :pb_memberfield, foreign_key: "member_id"
  has_one :pb_company, foreign_key: "member_id"
  has_many :pb_products, foreign_key: "member_id"
  has_many :pb_saleorders, foreign_key: "buyer_id"
  
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
              item.deal_saleorderitems_count(@deal),
              ApplicationController.helpers.format_price(item.deal_saleorderitems_total(@deal)),
              "<div class=\"text-nowrap\">#{item.last_bought_time_deal(@deal).strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "<div class=\"text-nowrap\">#{item.first_bought_time_deal(@deal).strftime("%d-%m-%Y, %H:%I %p")}</div>",
              "",
              ""
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
  
  def deal_saleorderitems(deal)
    deal.pb_saleorderitems.joins(:pb_saleorder).where(pb_saleorders: {buyer_id: self.id}).uniq
  end
  
  def deal_saleorderitems_count(deal)
    deal_saleorderitems(deal).sum(:quantity)
  end
  
  def deal_saleorderitems_total(deal)
    total = 0.0
    deal_saleorderitems(deal).each do |item|
      total += item.quantity.to_f*item.price.to_f
    end
    
    return total
  end
  
  def orders_by_deal(deal)
    pb_saleorders.joins(:pb_saleorderitems).where(pb_saleorderitems: {deal_id: deal.id}).uniq
  end
  
  def last_bought_time_deal(deal)
    Time.at(orders_by_deal(deal).order("created DESC").first.created).to_datetime
  end
  
  def first_bought_time_deal(deal)
    Time.at(orders_by_deal(deal).order("created").first.created).to_datetime
  end
end