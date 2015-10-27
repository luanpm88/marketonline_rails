class AddCountryToAdClicks < ActiveRecord::Migration
  def change
    add_column :ad_clicks, :country, :string
  end
end
