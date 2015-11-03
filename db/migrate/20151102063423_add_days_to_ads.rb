class AddDaysToAds < ActiveRecord::Migration
  def change
    add_column :ads, :days, :integer
  end
end
