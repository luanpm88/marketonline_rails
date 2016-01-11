class AddTotalSellersToPbMembers < ActiveRecord::Migration
  def change
    add_column :pb_members, :total_sellers, :decimal
  end
end
