class CreateSystemMessages < ActiveRecord::Migration
  def change
    create_table :pb_system_messages do |t|
      t.string :code
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
