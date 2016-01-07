class AddViewedToPbAds < ActiveRecord::Migration
  def change
    add_column :ads, :viewed, :integer
  end
end
