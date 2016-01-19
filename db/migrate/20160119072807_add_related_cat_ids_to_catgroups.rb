class AddRelatedCatIdsToCatgroups < ActiveRecord::Migration
  def change
    add_column :pb_catgroups, :related_cat_ids, :text
  end
end
