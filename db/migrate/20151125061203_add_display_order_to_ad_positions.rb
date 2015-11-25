class AddDisplayOrderToAdPositions < ActiveRecord::Migration
  def change
    add_column :ad_positions, :display_order, :integer
  end
end
