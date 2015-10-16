class PbMemberfield < ActiveRecord::Base
  belongs_to :pb_member, foreign_key: "member_id"
end