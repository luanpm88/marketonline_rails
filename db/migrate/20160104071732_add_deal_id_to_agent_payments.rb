class AddDealIdToAgentPayments < ActiveRecord::Migration
  def change
    add_column :agent_payments, :deal_id, :integer
  end
end
