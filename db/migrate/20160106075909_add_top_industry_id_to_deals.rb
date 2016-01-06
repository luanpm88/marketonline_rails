class AddTopIndustryIdToDeals < ActiveRecord::Migration
  def change
    add_column :pb_deals, :top_industry_id, :integer
  end
end
