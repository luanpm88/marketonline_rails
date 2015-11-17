class AddActiveToAds < ActiveRecord::Migration
  def change
    add_column :ads, :active, :integer, default: 0
  end
end
