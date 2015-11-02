class AddMaxBudgetToAds < ActiveRecord::Migration
  def change
    add_column :ads, :max_budget, :decimal
  end
end
