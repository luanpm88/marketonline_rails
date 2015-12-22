class PbSaleorder < ActiveRecord::Base
  has_many :pb_saleorderitems, foreign_key: "saleorder_id"
  belongs_to :buyer, class_name: "PbMember", foreign_key: "buyer_id"
  belongs_to :seller, class_name: "PbMember", foreign_key: "seller_id"
end