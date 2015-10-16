class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads, :options => 'COLLATE=utf8_general_ci' do |t|
      t.string :name
      t.text :description
      t.integer :ad_position_id
      t.text :url
      t.string :image
      t.integer :user_id
      t.string :status

      t.timestamps null: false
    end
  end
end
