class AddImagesToPbCountries < ActiveRecord::Migration
  def change
    add_column :pb_countries, :image, :string
    add_column :pb_countries, :image_2, :string
    add_column :pb_countries, :image_3, :string
    add_column :pb_countries, :image_4, :string
  end
end
