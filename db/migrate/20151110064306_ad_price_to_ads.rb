class AdPriceToAds < ActiveRecord::Migration
  def change
    add_column :ads, :display_price, :decimal
  end
end
