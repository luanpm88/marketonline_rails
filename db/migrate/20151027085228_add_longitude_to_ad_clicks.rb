class AddLongitudeToAdClicks < ActiveRecord::Migration
  def change
    add_column :ad_clicks, :longitude, :string
  end
end
