class AddSharePriceToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :share_price, :decimal
  end
end
