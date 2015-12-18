class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :pb_product_id, index: true
      t.integer :pb_company_id, index: true
      t.datetime :start_at, index: true
      t.datetime :end_at, index: true
      t.integer :quantity
      t.decimal :price
      t.text :status
      t.text :description

      t.timestamps null: false
    end
  end
end
