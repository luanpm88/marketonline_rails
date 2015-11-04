class PbProduct < ActiveRecord::Base
  self.primary_key = :id
  
  def self.input_options(user)
    self.all.collect {|p| [p.name, p.id]}
  end
  
  def self.general_search(params, user)    
    result = self.where("LOWER(pb_products.name) LIKE ?", "%#{params[:q].strip.downcase}%").where(member_id: user.id).order("id DESC")
    if user.role != "admin"
      result = result.where(member_id: user.id)
    end
    
    result = result.limit(50).map {|model| {:id => model.id, :text => model.name} }
  end
  
  def pictures
    arr = []
    if picture.present?
      arr << (picture[0..3] == "http" ? picture : "http://marketonline.vn/attachment/"+picture)
    end
    if picture1.present?
      arr << (picture1[0..3] == "http" ? picture1 : "http://marketonline.vn/attachment/"+picture1)
    end
    if picture2.present?
      arr << (picture2[0..3] == "http" ? picture2 : "http://marketonline.vn/attachment/"+picture2)
    end
    if picture3.present?
      arr << (picture3[0..3] == "http" ? picture3 : "http://marketonline.vn/attachment/"+picture3)
    end
    if picture4.present?
      arr << (picture4[0..3] == "http" ? picture4 : "http://marketonline.vn/attachment/"+picture4)
    end
    return arr
  end
  
  def url
    "http://marketonline.vn/san-pham/#{id.to_s}/"+name.unaccent.downcase.gsub(/\s+/,"xaaaaax").gsub!(/\W/,'').gsub("xaaaaax","-").gsub(/\-+/,"-")
  end
end