class AddTotalSalesToPbMembers < ActiveRecord::Migration
  def change
    add_column :pb_members, :total_sales, :decimal
  end
end
