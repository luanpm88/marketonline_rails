class AddDisplayPriceUnitToAds < ActiveRecord::Migration
  def change
    add_column :ads, :display_price_unit, :string
  end
end
