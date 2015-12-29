class AddUpdatedAtToPbSaleorders < ActiveRecord::Migration
  def change
    add_column :pb_saleorders, :updated_at, :datetime
  end
end
