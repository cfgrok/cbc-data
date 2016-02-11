class Area < ActiveRecord::Base
  belongs_to :sector
  has_many :checklists

  def to_s
    "#{sector.code} - #{name}"
  end
end
