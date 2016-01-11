class AddRealTotalBoughtToPbMembers < ActiveRecord::Migration
  def change
    add_column :pb_members, :real_total_bought, :decimal
  end
end
