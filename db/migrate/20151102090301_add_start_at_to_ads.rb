class AddStartAtToAds < ActiveRecord::Migration
  def change
    add_column :ads, :start_at, :datetime
  end
end
