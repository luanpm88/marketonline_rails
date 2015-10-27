class AdClick < ActiveRecord::Base
  geocoded_by :ip
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.city    = geo.city
      obj.zipcode = geo.postal_code
      obj.country = geo.country_code
    end
  end
  after_validation :geocode
  after_validation :reverse_geocode
  
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
      # location = Geokit::Geocoders::IpGeocoder.geocode(item.ip).all.first
      # location = GeoIp.geolocation("118.69.191.130")
      # city = location.present? ? location[:city]+", "+location[:country_name] : ""
      row = [
              item.city+", "+item.country,
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