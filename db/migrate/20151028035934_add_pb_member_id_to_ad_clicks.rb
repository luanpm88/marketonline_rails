class AddPbMemberIdToAdClicks < ActiveRecord::Migration
  def change
    add_column :ad_clicks, :pb_member_id, :integer
  end
end
