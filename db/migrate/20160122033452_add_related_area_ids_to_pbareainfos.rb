class AddRelatedAreaIdsToPbareainfos < ActiveRecord::Migration
  def change
    add_column :pb_areainfos, :related_area_ids, :text
  end
end
