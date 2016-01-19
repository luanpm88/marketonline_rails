class PbIndustry < ActiveRecord::Base
  has_many :deals, foreign_key: "top_industry_id"
  
  def self.input_options(lvl=1, user)
    options = [["- Chọn chuyên mục -",""]]
    if user.role == "admin"
        options += [["Mặc định", -1]]
    end
    options += self.where(level: lvl).order("display_order").collect {|p| [p.name, p.id]}        
  end
  
  def top_parent
    top_parentid == 0 ? self : PbIndustry.find(top_parentid)
  end

  def active_deals
    return deals.where(status: 1).where(approved: 1)
  end
  
  def self.general_search(params, user)
    result = self.all
    result = result.limit(50).map {|model| {:id => model.id, :text => model.name}}
  end
  
end