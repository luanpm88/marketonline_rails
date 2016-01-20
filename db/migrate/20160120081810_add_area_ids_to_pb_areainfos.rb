class AddAreaIdsToPbAreainfos < ActiveRecord::Migration
  def change
    add_column :pb_areainfos, :area_ids, :text
  end
end
