class PbSaleorderitem < ActiveRecord::Base
  self.primary_key = :id
  
  belongs_to :deal
  belongs_to :pb_saleorder, foreign_key: "saleorder_id"
  
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
              "",
              "",
              "",
              "",
              "",
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
  
end