class AddAgentUsernameToPbSaleorderitems < ActiveRecord::Migration
  def change
    add_column :pb_saleorderitems, :agent_username, :string
  end
end
