class PbAreatype < ActiveRecord::Base
  has_many :pb_areas, class_name: "PbArea", foreign_key: "areatype_id"
end