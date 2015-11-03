class AddPaymentTypeToAds < ActiveRecord::Migration
  def change
    add_column :ads, :payment_type, :string
  end
end
