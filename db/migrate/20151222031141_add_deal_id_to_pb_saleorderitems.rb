class AddDealIdToPbSaleorderitems < ActiveRecord::Migration
  def change
    add_column :pb_saleorderitems, :deal_id, :integer
  end
end
