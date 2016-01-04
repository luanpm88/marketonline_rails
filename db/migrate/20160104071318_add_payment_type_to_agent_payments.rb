class AddPaymentTypeToAgentPayments < ActiveRecord::Migration
  def change
    add_column :agent_payments, :payment_type, :string, default: 'discount'
  end
end
