class PbArea < ActiveRecord::Base
  belongs_to :parent, class_name: "PbArea", foreign_key: "parent_id"
  belongs_to :pb_areatype, class_name: "PbAreatype", foreign_key: "areatype_id"
  
  def self.general_search(params, user)
    result = self.where.not(id: 1)
    result = result.where("LOWER(pb_areas.name) LIKE ?", "%#{params[:q].strip.downcase}%")
   
    result = result.limit(200).map {|model| {:id => model.id, :text => model.full_name_inverse} }
    result.unshift({"text": "Miền Nam", "id": -2})
    result.unshift({"text": "Miền Trung", "id": -3})
    result.unshift({"text": "Miền Bắc", "id": -4})
    
    if user.role == "admin"
        result.unshift({"text": "Mặc định", "id": -1})
    end
    
    return result
  end
  
  def areatype
    if self.level == 3
      self.parent.pb_areatype
    else
      self.pb_areatype
    end    
  end
  
  def full_name
    names = []
    current = self
    while !current.nil?
      names << current.name
      current = current.parent
    end
    return names.join(", ")
  end
  
  def full_name_inverse
    names = []
    current = self
    while !current.nil?
      names.unshift(current.name)
      current = current.parent
    end
    return names.join(" - ")
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
    
    if self.id
        str << pb_areatype.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
        str << self.id    
        str << self.name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub(/[^a-zA-Z0-9]/, '').gsub("xaaaaax","-")
    end
    
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
  
  def self.select_toptions
    
    result = self.where.not(id: 1)
    #result = result.where("LOWER(pb_areas.name) LIKE ?", "%#{params[:q].strip.downcase}%")
   
    result = result.map {|model| [model.full_name_inverse, model.id] }
    #result.unshift(["Miền Nam", -2])
    #result.unshift(["Miền Trung", -3])
    #result.unshift(["Miền Bắc", -4])
    
    return result
  end
  
end