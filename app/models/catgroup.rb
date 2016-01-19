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
  
end
