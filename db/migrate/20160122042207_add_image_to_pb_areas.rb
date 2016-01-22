class AddImageToPbAreas < ActiveRecord::Migration
  def change
    add_column :pb_areas, :image, :string
  end
end
