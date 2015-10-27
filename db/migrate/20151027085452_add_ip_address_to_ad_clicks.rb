class AddIpAddressToAdClicks < ActiveRecord::Migration
  def change
    add_column :ad_clicks, :ip_address, :string
  end
end
