class CreateAgentPayments < ActiveRecord::Migration
  def change
    create_table :agent_payments do |t|
      t.integer :pb_member_id
      t.decimal :amount
      t.integer :user_id
      t.text :note

      t.timestamps null: false
    end
  end
end
