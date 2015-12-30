class AddApprovedToDeals < ActiveRecord::Migration
  def change
    add_column :pb_deals, :approved, :integer, default: 0
  end
end
