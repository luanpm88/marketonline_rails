class PbSaleorderitem < ActiveRecord::Base
  belongs_to :deal
  belongs_to :pb_saleorder, foreign_key: "saleorder_id"
end