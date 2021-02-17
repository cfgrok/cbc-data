class Sector < ActiveRecord::Base
  include Summarizable

  attr_accessor :sector_survey

  has_many :areas
  has_many :checklists

  has_many :observations, -> { joins(:taxon).order('taxons.taxonomic_order') }, through: :checklists

  def to_s
    name
  end

  def observations
    if sector_survey
      super.select { |o| o.survey == sector_survey } 
    else
      super
    end
  end
end
