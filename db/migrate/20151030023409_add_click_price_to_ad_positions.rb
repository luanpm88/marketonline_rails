class AddClickPriceToAdPositions < ActiveRecord::Migration
  def change
    add_column :ad_positions, :click_price, :decimal
  end
end
