class AddImage4ToPbAreas < ActiveRecord::Migration
  def change
    add_column :pb_areas, :image_4, :string
  end
end
