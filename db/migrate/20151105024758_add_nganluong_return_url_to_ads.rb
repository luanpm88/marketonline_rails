class AddNganluongReturnUrlToAds < ActiveRecord::Migration
  def change
    add_column :ads, :nganluong_return_url, :text
  end
end
