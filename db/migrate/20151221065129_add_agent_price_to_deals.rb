class AddAgentPriceToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :agent_price, :decimal
  end
end
