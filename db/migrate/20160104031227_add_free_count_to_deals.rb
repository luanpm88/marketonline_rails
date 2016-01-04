class AddFreeCountToDeals < ActiveRecord::Migration
  def change
    add_column :pb_deals, :free_count, :integer
  end
end
