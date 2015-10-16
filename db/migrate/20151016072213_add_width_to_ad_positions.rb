class AddWidthToAdPositions < ActiveRecord::Migration
  def change
    add_column :ad_positions, :width, :integer
  end
end
