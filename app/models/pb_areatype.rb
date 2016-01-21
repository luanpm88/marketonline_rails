class PbAreatype < ActiveRecord::Base
  has_many :pb_areas, class_name: "PbArea", foreign_key: "areatype_id"
  
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