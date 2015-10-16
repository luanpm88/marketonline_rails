class Ad < ActiveRecord::Base
  mount_uploader :image, AdUploader
  
  validates :name, presence: true
  validates :ad_position_id, presence: true
  
  belongs_to :ad_position
  
  def self.datatable(params)    
    @records = self.joins(:ad_position).all
    
    order = "ads.created_at"
    if !params["order"].nil?
      case params["order"]["0"]["column"]
      when "1"
        order = "ads.name"
      when "2"
        order = "ad_positions.title"
      when "4"
        order = "ads.created_at"
      end
      order += " "+params["order"]["0"]["dir"]
    end
    @records = @records.order(order) if !order.nil?
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("LOWER(ads.name) LIKE ? OR LOWER(ad_positions.title) LIKE ?", "%#{q}%", "%#{q}%") if !q.empty?
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|      
      row = [
              item.image_link,
              item.name,
              "<div class=\"text-center\">#{item.ad_position.display_name}</div>",           
              "<div class=\"text-center\"></div>",
              "<div class=\"text-center\">#{item.created_at.strftime("%d-%m-%Y")}</div>",
              "<div class=\"text-right\"></div>"
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
  
  def image_path(version = nil)
    if self.image_url.nil?
      return "public/img/avatar.jpg"
    elsif !version.nil?
      return self.image_url(version)
    else
      return self.image_url
    end
  end
  
  def image_src(version = nil)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.url_for(controller: "ads", action: "image", id: self.id, type: version)
  end
  
  def display_image(version = nil)
    self.image_url.nil? ? "<i class=\"icon-picture icon-nopic-60\"></i>".html_safe : "<img width='60' src='#{image_src(version)}' />".html_safe
  end
  
  def image_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to(display_image(:square), image_src(:banner), class: "fancybox.image fancybox", title: name)
  end

end
