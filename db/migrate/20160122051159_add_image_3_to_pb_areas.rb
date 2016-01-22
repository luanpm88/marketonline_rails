class AddImage3ToPbAreas < ActiveRecord::Migration
  def change
    add_column :pb_areas, :image_3, :string
  end
end
