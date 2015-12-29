class AddFinishedToPbOrders < ActiveRecord::Migration
  def change
    add_column :pb_saleorders, :finished, :integer, default: 0
  end
end
