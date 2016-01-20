class AddEndAtToPbAreainfos < ActiveRecord::Migration
  def change
    add_column :pb_areainfos, :end_at, :datetime
  end
end
