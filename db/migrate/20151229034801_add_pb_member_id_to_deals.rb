class AddPbMemberIdToDeals < ActiveRecord::Migration
  def change
    add_column :pb_deals, :pb_member_id, :integer
  end
end
