class AddTotalBoughtToPbMembers < ActiveRecord::Migration
  def change
    add_column :pb_members, :total_bought, :decimal
  end
end
