class AddNameToDeals < ActiveRecord::Migration
  def change
    add_column :pb_deals, :name, :string
  end
end
