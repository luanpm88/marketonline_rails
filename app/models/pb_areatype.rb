class PbAreatype < ActiveRecord::Base
  has_many :pb_areas, class_name: "PbArea", foreign_key: "areatype_id"
  
  mount_uploader :image, AreaUploader
  mount_uploader :image_2, AreaUploader
  mount_uploader :image_3, AreaUploader
  mount_uploader :image_4, AreaUploader
  
  def self.datatable(params, user)    
    @records = self.order("name")
    
    # Keyword search
    q = params["search"]["value"].strip.downcase
    @records = @records.where("pb_areatypes.name LIKE ?", "%#{q}%") if !q.empty?
    
    #if params[:type_name].present?
    #  @records = @records.where("pb_areainfos.type_name = ?", params[:type_name])
    #end
    
    total = @records.count
    @records = @records.limit(params[:length]).offset(params["start"])
    data = []
    
    @records.each do |item|
      row = [
              '<img width="90" height="" src="'+item.image_thumb+'" />',
              '<img width="90" height="" src="'+item.image_2_thumb+'" />',
              '<img width="90" height="" src="'+item.image_3_thumb+'" />',
              '<img width="90" height="" src="'+item.image_4_thumb+'" />',
              item.name,
              item.edit_link(user),
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
  
  def edit_link(user)
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)
    link_helper = ActionController::Base.helpers
    
    link_helper.link_to("<i class=\"icon-pencil\"></i> Sửa".html_safe, {controller: "pb_areatypes", action: "edit", id: self.id})
  end
  
  def image_thumb
	if !image.present?
	  return "http://marketonline.vn/images/icon/announce.png"	
	else
	  return "http://marketonline.vn:3000/"+image.quare.url.to_s
	end
  end
  
  def image_2_thumb
	if !image_2.present?
	  return "http://marketonline.vn/images/icon/announce.png"
	else
	  return "http://marketonline.vn:3000/"+image_2.quare.url.to_s
	end
  end
  
  def image_3_thumb
	if !image_3.present?
	  return "http://marketonline.vn/images/icon/announce.png"
	else
	  return "http://marketonline.vn:3000/"+image_3.quare.url.to_s
	end
  end
  
  def image_4_thumb
	if !image_4.present?
	  return "http://marketonline.vn/images/icon/announce.png"
	else
	  return "http://marketonline.vn:3000/"+image_4.quare.url.to_s
	end
  end
  
  def area_link(params)
    str = ["http://marketonline.vn"]
    str << ["thi-truong"]
    #if params[:areatype_id].present?
    #  str << PbAreatype.find(params[:areatype_id]).name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    #end
    #if params[:area_id].present?
    #  str << PbArea.find(params[:area_id]).id
    #  str << PbArea.find(params[:area_id]).name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    #end
    
    str << self.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    
    if params[:type].present? && !params[:info_page].present?
      str << params[:type]
    end
    
    if params[:catgroup_id].present? && !params[:info_page].present?
      str << "vung-mien"
      str << params[:catgroup_id]
      str << Catgroup.find(params[:catgroup_id]).name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    
    if params[:info_page].present?
      str << params[:info_page]
    end
    
    return str.join("/")
  end
end