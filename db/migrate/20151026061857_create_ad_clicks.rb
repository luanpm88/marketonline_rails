class CreateAdClicks < ActiveRecord::Migration
  def change
    create_table :ad_clicks do |t|
      t.integer :ad_id
      t.text :customer_code
      t.string :ip

      t.timestamps null: false
    end
  end
end
