class AddDealTypeToPbDeals < ActiveRecord::Migration
  def change
    add_column :pb_deals, :deal_type, :string, default: "discount"
  end
end
