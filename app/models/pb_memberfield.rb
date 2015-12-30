class PbMemberfield < ActiveRecord::Base
  belongs_to :pb_member, foreign_key: "member_id"
  belongs_to :pb_area, foreign_key: "area_id"
end