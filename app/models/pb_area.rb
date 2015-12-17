class PbArea < ActiveRecord::Base
  belongs_to :parent, class_name: "PbArea", foreign_key: "parent_id"
  belongs_to :pb_areatype, class_name: "PbAreatype", foreign_key: "areatype_id"
  
  def self.general_search(params, user)
    result = self.where.not(id: 1)
    result = result.where("LOWER(pb_areas.name) LIKE ?", "%#{params[:q].strip.downcase}%")
   
    result = result.limit(50).map {|model| {:id => model.id, :text => model.full_name_inverse} }
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
end