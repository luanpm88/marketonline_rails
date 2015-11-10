class AddDescription2ToAds < ActiveRecord::Migration
  def change
    add_column :ads, :description_2, :text
  end
end
