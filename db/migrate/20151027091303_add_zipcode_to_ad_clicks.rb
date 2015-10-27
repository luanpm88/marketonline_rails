class AddZipcodeToAdClicks < ActiveRecord::Migration
  def change
    add_column :ad_clicks, :zipcode, :string
  end
end
