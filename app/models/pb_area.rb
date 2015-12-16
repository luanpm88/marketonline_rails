class PbArea < ActiveRecord::Base
  belongs_to :parent, class_name: "PbArea", foreign_key: "parent_id"
  
  def self.general_search(params, user)
    result = self.all
    result = result.where("LOWER(pb_areas.name) LIKE ?", "%#{params[:q].strip.downcase}%")
   
    result = result.limit(50).map {|model| {:id => model.id, :text => model.full_name_inverse} }
    if user.role == "admin"
        result.unshift({"text": "Mặc định", "id": -1})
    end
    
    return result
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