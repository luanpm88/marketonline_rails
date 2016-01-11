class AddTotalBoughtProductsToPbMembers < ActiveRecord::Migration
  def change
    add_column :pb_members, :total_bought_products, :integer
  end
end
