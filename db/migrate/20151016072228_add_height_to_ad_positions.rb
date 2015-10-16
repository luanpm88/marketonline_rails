class AddHeightToAdPositions < ActiveRecord::Migration
  def change
    add_column :ad_positions, :height, :integer
  end
end
