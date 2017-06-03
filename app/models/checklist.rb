class Checklist < ActiveRecord::Base
  include Summarizable

  belongs_to :survey
  belongs_to :sector
  belongs_to :area

  has_many :observations, -> { joins(:taxon).order('taxons.taxonomic_order') }, dependent: :destroy

  accepts_nested_attributes_for :observations, allow_destroy: true

  has_and_belongs_to_many :observers, -> { order 'last_name, first_name' }

  scope :field, -> { where(feeder_watch: false) }
  scope :feeder, -> { where(feeder_watch: true) }

  scope :has_start_time, -> { where('start_time is not null') }
  scope :has_end_time, -> { where('end_time is not null') }

  def to_s
    "#{survey.to_s}: #{feeder_watch ? location : area.to_s}"
  end

  def rows
    @row_observations ||= observations
    @rows ||= Taxon.all.map do |taxon|
      Row.new(taxon, @row_observations.find {|o| o.taxon == taxon})
    end
  end

  def aggregate_observations
    aggregated = super

    sector_observations = sector.aggregate_observations if sector
    survey_observations = survey.aggregate_observations

    aggregated.each do |observation|
      observation.sector_number = sector_observations.find { |o| o.taxon == observation.taxon }.number if sector
      observation.survey_number = survey_observations.find { |o| o.taxon == observation.taxon }.number
    end
  end

  def hours_match?
    hours_total &&
    [hours_foot, hours_car, hours_boat, hours_owling].compact.reduce(:+) == hours_total
  end

  def miles_match?
    !no_field_miles? &&
    [miles_foot, miles_car, miles_boat, miles_owling].compact.reduce(:+) == miles_total
  end

  def field_hours
    unless hours_total
      'MISSING'
    else
      hours_total
    end
  end

  def field_miles
    if no_field_miles?
      'MISSING'
    else
      miles_total
    end
  end

  private

  def no_field_miles?
    !feeder_watch && !miles_total
  end
end
