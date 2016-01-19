class AddDisplayOrderToCatgroups < ActiveRecord::Migration
  def change
    add_column :pb_catgroups, :display_order, :integer
  end
end
