class PbMember < ActiveRecord::Base  
  self.primary_key = :id
  
  has_one :pb_memberfield, foreign_key: "member_id"
  has_one :pb_company, foreign_key: "member_id"
  has_many :pb_products, foreign_key: "member_id"
  
  def display_name
    pb_memberfield.first_name+" "+pb_memberfield.last_name
  end
  
  def all_pb_products
    pb_products.where(status: 1).where(valid_status: 1)
  end
  
  def image
    if !pb_company.nil? && pb_company.picture.present?
      "http://marketonline.vn/attachment/#{pb_company.picture}"
    elsif photo.present?
      "http://marketonline.vn/attachment/#{photo}"
    else
      "/app/assets/images/placeholder.jpg"
    end
  end
  
  def shop_url
    pb_company.nil? ? nil : "/#{pb_company.cache_spacename}"
  end
  
  def referrer
    (referrer_id.present? and referrer_id > 0) ? PbMember.find(referrer_id) : PbMember.first
  end
end