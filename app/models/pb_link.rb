class PbLink < ActiveRecord::Base
  belongs_to :pb_member, foreign_key: "member_id"
  belongs_to :parent, class_name: "PbMember"
  
end