class Observation < ActiveRecord::Base
  attr_accessor :sector_number, :survey_number

  belongs_to :taxon
  belongs_to :checklist

  delegate :common_name, to: :taxon

  scope :by_common_name, ->(common_name) { joins(:taxon).where('taxons.common_name = ?', common_name) }

  def sector_ratio
    number ? number.fdiv(sector_number) : ""
  end

  def survey_ratio
    number ? number.fdiv(survey_number) : ""
  end
end
