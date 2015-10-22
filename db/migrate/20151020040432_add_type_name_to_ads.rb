class AddTypeNameToAds < ActiveRecord::Migration
  def change
    add_column :ads, :type_name, :string
  end
end
