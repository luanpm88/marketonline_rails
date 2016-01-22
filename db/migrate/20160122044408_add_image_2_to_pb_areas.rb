class AddImage2ToPbAreas < ActiveRecord::Migration
  def change
    add_column :pb_areas, :image_2, :string
  end
end
