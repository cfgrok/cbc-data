# frozen_string_literal: true

class Checklist < ActiveRecord::Base
  include Summarizable

  belongs_to :survey
  belongs_to :sector
  belongs_to :area

  has_many :observations, -> { joins(:taxon).includes(:taxon).order("taxons.taxonomic_order") },
    dependent: :destroy, inverse_of: :checklist

  accepts_nested_attributes_for :observations, allow_destroy: true

  has_many :teams, dependent: :delete_all
  has_many :observers, -> { order "last_name, first_name" }, through: :teams

  scope :field, -> { where(feeder_watch: false) }
  scope :feeder, -> { where(feeder_watch: true) }

  scope :has_start_time, -> { where.not(start_time: nil) }
  scope :has_end_time, -> { where.not(end_time: nil) }

  ObservationData = Struct.new(
    :survey_number,
    :sector_number,
  )

  def to_s
    "#{survey}: #{feeder_watch ? location : area.to_s}"
  end

  def rows
    @row_observations ||= observations
    @rows ||= Taxon.all.map do |taxon|
      Row.new(taxon, @row_observations.find { |o| o.taxon == taxon })
    end
  end

  # rubocop:todo Metrics/AbcSize
  # rubocop:todo Metrics/CyclomaticComplexity
  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Metrics/PerceivedComplexity
  def aggregate_observations
    observations = super
    observation_taxon_ids = observations.map(&:taxon_id)

    sector.sector_survey_id = survey.id

    survey_observations = survey.observations.select { |o| observation_taxon_ids.include? o.taxon_id }
    sector_observation_ids = sector.observations.select { |o| observation_taxon_ids.include? o.taxon_id }.map(&:id)

    observation_data = observations.each_with_object({}) do |observation, data|
      data[observation.taxon_id] = ObservationData.new(0, 0)
    end

    survey_observations.each do |observation|
      data = observation_data[observation.taxon_id]

      if observation.count_week && data.survey_number.zero?
        data.survey_number == "Count Week"
      elsif observation.number
        data.survey_number = 0 if data.survey_number == "Count Week"
        data.survey_number += observation.number
      end

      next unless sector_observation_ids.include? observation.id

      if observation.count_week && data.sector_number.zero?
        data.sector_number == "Count Week"
      elsif observation.number
        data.sector_number = 0 if data.sector_number == "Count Week"
        data.sector_number += observation.number
      end
    end

    observations.each do |observation|
      data = observation_data[observation.taxon_id]
      observation.survey_number = data.survey_number
      observation.sector_number = data.sector_number
    end

    observations
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  def times_match?
    duration && duration - (break_hours || 0) == hours_total
  end

  def duration
    end_time && (((end_time - start_time) / 900).round.fdiv(4) * (min_parties && min_parties.positive? ? min_parties : 1))
  end

  def hours_match?
    hours_total &&
      [hours_foot, hours_car, hours_boat, hours_owling].compact.sum == hours_total
  end

  def miles_match?
    !no_field_miles? &&
      [miles_foot, miles_car, miles_boat, miles_owling].compact.sum == miles_total
  end

  def field_hours
    hours_total || "MISSING"
  end

  def field_miles
    if no_field_miles?
      "MISSING"
    else
      miles_total
    end
  end

  private

  def no_field_miles?
    !feeder_watch && !miles_total
  end
end
