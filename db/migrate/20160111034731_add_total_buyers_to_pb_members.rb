class AddTotalBuyersToPbMembers < ActiveRecord::Migration
  def change
    add_column :pb_members, :total_buyers, :integer
  end
end
