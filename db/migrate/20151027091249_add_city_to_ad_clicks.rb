class AddCityToAdClicks < ActiveRecord::Migration
  def change
    add_column :ad_clicks, :city, :string
  end
end
