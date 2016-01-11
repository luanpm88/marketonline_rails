class AddRealTotalSalesToPbMembers < ActiveRecord::Migration
  def change
    add_column :pb_members, :real_total_sales, :integer
  end
end
