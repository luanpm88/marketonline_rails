class AddImageToPbAreainfos < ActiveRecord::Migration
  def change
    add_column :pb_areainfos, :image, :string
  end
end
