class PbMember < ActiveRecord::Base  
  self.primary_key = :id
  
  has_one :pb_memberfield, foreign_key: "member_id"
  has_one :pb_company, foreign_key: "member_id"
  
  def display_name
    pb_memberfield.first_name+" "+pb_memberfield.last_name
  end
  
  def image
    if !pb_company.nil? && pb_company.picture.present?
      "/attachment/#{pb_company.picture}"
    elsif photo.present?
      "/attachment/#{photo}"
    else
      "/app/assets/images/placeholder.jpg"
    end
  end
  
  def shop_url
    pb_company.nil? ? nil : "/#{pb_company.cache_spacename}"
  end
end