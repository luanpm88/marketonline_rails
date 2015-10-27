class AdClick < ActiveRecord::Base
  def self.datatable(params)    
    @records = self.all
    
    order = "ad_clicks.created_at DESC"
    if !params["order"].nil?
      case params["order"]["0"]["column"]
      when "2"
        order = "ad_clicks.name"      
      end
      order += " "+params["order"]["0"]["dir"]
    end
    @records = @records.order(order) if !order.nil?
    
    ## Keyword search
    #q = params["search"]["value"].strip.downcase
    #@records = @records.where("LOWER(ads.name) LIKE ?", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      location = Geokit::Geocoders::IpGeocoder.geocode(item.ip).all.first
      city = location.present? ? location.city.to_s+", "+location.country.to_s : ""
      row = [
              city,
              "<div class=\"text-center\">"+item.ip+"</div>",
              "<span class=\"text-muted\">#{item.created_at.strftime("%d/%m/%Y")}, #{item.created_at.strftime("%H:%m %P")}</span>"
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