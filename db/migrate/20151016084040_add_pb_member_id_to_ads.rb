class AddPbMemberIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :pb_member_id, :integer
  end
end
