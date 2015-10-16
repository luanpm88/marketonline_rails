class AdPosition < ActiveRecord::Base
  validates :name, presence: true
  
  def display_name
    "#{title} (#{width.to_s} x #{height.to_s})"
  end
end
