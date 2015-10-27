class AddLatitudeToAdClicks < ActiveRecord::Migration
  def change
    add_column :ad_clicks, :latitude, :string
  end
end
