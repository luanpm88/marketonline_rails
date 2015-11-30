class AddPbIndustryIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :pb_industry_id, :integer
  end
end
