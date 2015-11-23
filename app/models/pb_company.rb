class PbCompany < ActiveRecord::Base  
  self.primary_key = :id
  
  belongs_to :pb_member, foreign_key: "member_id"
  
  def display_name
    pb_memberfield.first_name+" "+pb_memberfield.last_name
  end
  
  def image
    if !photo.present?
      "assets/images/placeholder.jpg"
    else
      "http://marketonline.vn/attachment/#{photo}"
    end
  end
end