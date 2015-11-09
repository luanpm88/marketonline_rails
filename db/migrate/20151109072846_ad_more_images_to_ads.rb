class AdMoreImagesToAds < ActiveRecord::Migration
  def change
    add_column :ads, :image_2, :string
    add_column :ads, :image_3, :string
    add_column :ads, :image_4, :string
  end
end
