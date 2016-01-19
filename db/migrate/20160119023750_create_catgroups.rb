class CreateCatgroups < ActiveRecord::Migration
  def change
    create_table :pb_catgroups do |t|
      t.string :name
      t.text :cat_ids
      t.string :image

      t.timestamps null: false
    end
  end
end
