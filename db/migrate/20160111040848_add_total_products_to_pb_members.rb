class AddTotalProductsToPbMembers < ActiveRecord::Migration
  def change
    add_column :pb_members, :total_sold_products, :integer
  end
end
