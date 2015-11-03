class AddEndAtToAds < ActiveRecord::Migration
  def change
    add_column :ads, :end_at, :datetime
  end
end
