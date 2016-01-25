class AddStatusToAdPositions < ActiveRecord::Migration
  def change
    add_column :ad_positions, :status, :integer, default: 1
  end
end
