class AddImagesToPbAreatypes < ActiveRecord::Migration
  def change
    add_column :pb_areatypes, :image, :string
    add_column :pb_areatypes, :image_2, :string
    add_column :pb_areatypes, :image_3, :string
    add_column :pb_areatypes, :image_4, :string
  end
end
