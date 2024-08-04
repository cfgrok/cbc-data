# frozen_string_literal: true

class Sector < ActiveRecord::Base
  include Summarizable

  attr_accessor :sector_survey_id

  has_many :areas
  has_many :checklists

  has_many :observations, -> { joins(:taxon).includes(:taxon).order("taxons.taxonomic_order") }

  def to_s
    name
  end

  def observations
    if sector_survey_id
      super.select { |o| o.survey_id == sector_survey_id }
    else
      super
    end
  end
end
