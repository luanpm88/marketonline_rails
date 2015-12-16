class AddPbAreaIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :pb_area_id, :integer
  end
end
