class PbCompany < ActiveRecord::Base  
  self.primary_key = :id
  
  belongs_to :pb_member, foreign_key: "member_id"
  belongs_to :pb_area, foreign_key: "area_id"
  
  def display_name
    pb_memberfield.first_name+" "+pb_memberfield.last_name
  end
  
  def image
    if !picture.present?
      "assets/images/placeholder.jpg"
    else
      "http://marketonline.vn/attachment/#{picture}"
    end
  end
  
  def url
    "http://marketonline.vn/#{cache_spacename}"
  end
  
  def display_address
    address+", "+pb_area.full_name
  end
  
end