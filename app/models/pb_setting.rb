class PbSetting < ActiveRecord::Base
  def self.get(val)
    return self.where(variable: val).first
  end
end