class AddStartAtToPbAreainfos < ActiveRecord::Migration
  def change
    add_column :pb_areainfos, :start_at, :datetime
  end
end
