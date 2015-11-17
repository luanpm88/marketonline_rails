class AddNumberOfAdToAdPositions < ActiveRecord::Migration
  def change
    add_column :ad_positions, :number_of_ad, :integer, default: 1
  end
end
