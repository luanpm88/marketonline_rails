class AddSyleNameToAdPositions < ActiveRecord::Migration
  def change
    add_column :ad_positions, :style_name, :string
  end
end
