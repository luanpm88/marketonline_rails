class Catgroup < ActiveRecord::Base
  self.table_name = "pb_catgroups"
  
  mount_uploader :image, CatgroupUploader
  
  
  def industry_ids
    return [] if cat_ids.nil?
    JSON.parse(cat_ids)
  end
  
  def industries    
    PbIndustry.where(id: industry_ids)
  end
  
  def update_all_cat_ids
    
  end
  
  def self.ordered
    self.all.order("display_order")
  end
  
  def update_related_cat_ids
    ids = []
    industries.each do |i|
      ids += i.children.split(",")
    end
    
    self.update_attribute(:related_cat_ids, ids.join(","))
    
    return ids
  end
  
  def area_link(params)
    str = ["http://marketonline.vn"]
    str << ["thi-truong"]
    if params[:areatype_id].present?
      str << PbAreatype.find(params[:areatype_id]).name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    if params[:area_id].present?
      str << PbArea.find(params[:area_id]).id
      str << PbArea.find(params[:area_id]).name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    if params[:type].present?
      str << params[:type]
    end
    return str.join("/")
  end
  
end
