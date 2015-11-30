class PbIndustry < ActiveRecord::Base
  def self.input_options(lvl=1, user)
    options = [["- Chọn chuyên mục -",""]]
    if user.role == "admin"
        options += [["Mặc định", -1]]
    end
    options += self.where(level: lvl).order("display_order").collect {|p| [p.name, p.id]}        
  end
end