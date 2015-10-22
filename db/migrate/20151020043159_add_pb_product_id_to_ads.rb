class AddPbProductIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :pb_product_id, :integer
  end
end
