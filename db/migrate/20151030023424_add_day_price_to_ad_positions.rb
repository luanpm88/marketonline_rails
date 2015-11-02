class AddDayPriceToAdPositions < ActiveRecord::Migration
  def change
    add_column :ad_positions, :day_price, :decimal
  end
end
