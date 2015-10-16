class CreateAdPositions < ActiveRecord::Migration
  def change
    create_table :ad_positions, :options => 'COLLATE=utf8_general_ci' do |t|
      t.string :name
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
