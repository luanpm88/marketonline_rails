class AddDealPriceToPbSaleorderitems < ActiveRecord::Migration
  def change
    add_column :pb_saleorderitems, :deal_price, :decimal
  end
end
