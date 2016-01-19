class PbIndustry < ActiveRecord::Base
  has_many :deals, foreign_key: "top_industry_id"
  has_many :child_cats, class_name: "PbIndustry", foreign_key: "parent_id"
  
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
  
  def find_child_cats
    ids = [self.id]
    ids += child_cats.map(&:id)
    child_cats.each do |c|
      ids += c.child_cats.map(&:id)
      c.child_cats.each do |cc|
        ids += cc.child_cats.map(&:id)
        cc.child_cats.each do |ccc|
          ids += ccc.child_cats.map(&:id)
          ccc.child_cats.each do |cccc|
            ids += cccc.child_cats.map(&:id)
            cccc.child_cats.each do |ccccc|
              ids += ccccc.child_cats.map(&:id)
            end
          end
        end
      end
    end
    self.update_attribute(:children, ids.join(","))
    
    return ids
  end
  
end