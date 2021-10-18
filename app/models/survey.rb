class Survey < ActiveRecord::Base
  include Summarizable

  belongs_to :year
  has_many :checklists
  has_many :observations, -> { joins(:taxon).includes(:taxon).order('taxons.taxonomic_order') }

  validates :year, presence: true

  delegate :to_s, to: :year

  SurveyCount = Struct.new(
    :species_list,
    :species_total,
    :count_week_list,
    :count_week_total,
    :individual_total
  )
  TaxonObservation = Struct.new(
    :name,
    :count,
    :years,
    :ten_year_avg,
    :ten_year_change,
    :prior_year_avg,
    :prior_year_change,
    :high,
    :low,
    :all_years,
    :all_year_avg
  )

  def aggregate_observations
    aggregated = super

    taxons = Taxon.where("EXISTS(SELECT 1 FROM observations WHERE taxons.id = observations.taxon_id)")

    taxons.map do |t|
      if existing = aggregated.find {|e| e.taxon_id == t.id}
        existing
      else
        Observation.new(taxon_id: t.id)
      end
    end
  end

  def totals_avg(totals)
    return if totals.empty? || totals.sum == 0
    (totals.sum.to_f / totals.size).round 1
  end

  def percent_change(totals, current)
    return if totals.empty? || !current || current == 0
    avg = totals_avg totals
    return if !avg || avg == 0
    ((current.to_f / avg - 1) * 100).round 2
  end

  def all_survey_species_avg
    (all_survey_species_totals.sum.to_f / all_survey_species_totals.size).round
  end

  def prior_survey_species_avg
    return if prior_survey_species_totals.empty?
    (prior_survey_species_totals.sum.to_f / prior_survey_species_totals.size).round
  end

  def prior_survey_species_change
    return if prior_survey_species_totals.empty?
    (species_total.to_f / prior_survey_species_avg - 1) * 100
  end

  def ten_year_species_avg
    return if ten_year_species_totals.empty?
    (ten_year_species_totals.sum.to_f / ten_year_species_totals.size).round
  end

  def ten_year_species_change
    return if ten_year_species_totals.empty?
    (species_total.to_f / ten_year_species_avg - 1) * 100
  end

  def all_survey_individual_avg
    (all_survey_individual_totals.sum.to_f / all_survey_individual_totals.size).round
  end

  def prior_survey_individual_avg
    return if prior_survey_individual_totals.empty?
    (prior_survey_individual_totals.sum.to_f / prior_survey_individual_totals.size).round
  end

  def prior_survey_individual_change
    return if prior_survey_individual_totals.empty?
    (individual_total.to_f / prior_survey_individual_avg - 1) * 100
  end

  def ten_year_individual_avg
    return if ten_year_individual_totals.empty?
    (ten_year_individual_totals.sum.to_f / ten_year_individual_totals.size).round
  end

  def ten_year_individual_change
    return if ten_year_individual_totals.empty?
    (individual_total.to_f / ten_year_individual_avg - 1) * 100
  end

  def species_high
    @species_high = all_survey_species_totals.max
  end

  def species_high_record?
    species_total == species_high
  end

  def species_low
    @species_low = all_survey_species_totals.min
  end

  def species_low_record?
    species_total == species_low
  end

  def individual_high
    @individual_high = all_survey_individual_totals.max
  end

  def individual_high_record?
    individual_total == individual_high
  end

  def individual_low
    @individual_low = all_survey_individual_totals.min
  end

  def individual_low_record?
    individual_total == individual_low
  end

  def all_surveys
    @all_surveys ||= Survey.joins(:year).includes(:year).order('years.audubon_year DESC')
  end

  def all_survey_observations
    @all_survey_observations ||= Observation.joins(:taxon, survey: :year)
      .includes(:taxon, survey: :year)
      .order('taxons.taxonomic_order, years.audubon_year DESC')
  end

  def all_survey_taxon_observations
    t = Benchmark.measure {
    @all_survey_taxon_observations ||= all_survey_observations.reduce({}) do |collection, observation|
      collection[observation.taxon_id] = create_taxon_observation(observation.common_name) unless collection.key? observation.taxon_id

      taxon_observation = collection[observation.taxon_id]

      if !taxon_observation.years[observation.survey_year]
        taxon_observation.years[observation.survey_year] = observation.count_week ? 'Count Week' : observation.number
      elsif !observation.count_week
        taxon_observation.years[observation.survey_year] = 0 if taxon_observation.years[observation.survey_year] == 'Count Week'
        taxon_observation.years[observation.survey_year] += observation.number
      end

      collection
    end.transform_values do |taxon_observation|
      all_values = taxon_observation.years.values
      current = taxon_observation.years[to_s] == 'Count Week' ? 0 : taxon_observation.years[to_s]

      taxon_observation.count = taxon_observation.years[to_s]
      taxon_observation.high = all_values.compact.reject {|v| v == 'Count Week'}.max
      taxon_observation.low = all_values.compact.reject {|v| v == 'Count Week'}.min
      taxon_observation.all_years = all_values.compact.size

      all_values.map! {|v| !v || v == 'Count Week' ? 0 : v}
      prior_year_values = all_values.drop (all_values.size - prior_years.size)
      ten_year_values = prior_year_values.take 10

      taxon_observation.ten_year_avg = totals_avg ten_year_values
      taxon_observation.ten_year_change = percent_change ten_year_values, current
      taxon_observation.prior_year_avg = totals_avg prior_year_values
      taxon_observation.prior_year_change = percent_change prior_year_values, current
      taxon_observation.all_year_avg = totals_avg all_values

      taxon_observation
    end
    }
    logger.debug 'all_survey_taxon_observations: ' + t.to_s
    @all_survey_taxon_observations
  end

  def all_survey_counts
    @all_survey_counts ||= all_survey_observations.reduce(survey_count_collection) do |collection, observation|
      count = collection[observation.survey_year]

      if observation.count_week
        count.count_week_list |= [observation.common_name]
      else
        count.species_list |= [observation.common_name]
        count.individual_total += observation.number
      end

      collection
    end.transform_values do |count|
      remove_invalid_count_week_observations count
      calculate_species_total count
      calculate_count_week_total count

      count
    end
  end

  private

  def prior_years
    all_surveys.map { |survey| survey.to_s }.reject { |year| year >= to_s }
  end

  def create_taxon_observation(name)
    TaxonObservation.new(name, nil, survey_year_collection, nil, nil, nil, nil, 0, 0, 0, nil)
  end

  def survey_year_collection
    all_surveys.reduce({}) do |collection, survey|
      collection[survey.to_s] = nil
      collection
    end
  end

  def survey_count_collection
    all_surveys.reduce({}) do |collection, survey|
      collection[survey.to_s] = SurveyCount.new([], 0, [], 0, 0)
      collection
    end
  end

  def remove_invalid_count_week_observations(count)
    count.count_week_list.reject! { |common_name| count.species_list.include? common_name }
  end

  def calculate_species_total(count)
    species_list = count.species_list.dup

    remove_spuhs species_list
    remove_slashes species_list
    remove_duplicates species_list
    count.species_total = species_list.size
  end

  def calculate_count_week_total(count)
    species_list = count.species_list.dup
    count_week_list = count.count_week_list.dup

    remove_spuhs count_week_list
    remove_slashes count_week_list
    remove_duplicates count_week_list, species_list
    count.count_week_total = count_week_list.size
  end

  def all_survey_species_totals
    all_survey_counts.map do |data|
      data.last.species_total
    end
  end

  def all_survey_count_week_totals
    all_survey_counts.map do |data|
      data.last.count_week_total
    end
  end

  def prior_survey_species_totals
    all_survey_species_totals.drop (all_surveys.size - prior_years.size)
  end

  def ten_year_species_totals
    prior_survey_species_totals.take 10
  end

  def all_survey_individual_totals
    all_survey_counts.sort.reverse.map do |data|
      data.last.individual_total
    end
  end

  def prior_survey_individual_totals
    all_survey_individual_totals.drop (all_surveys.size - prior_years.size)
  end

  def ten_year_individual_totals
    prior_survey_individual_totals.take 10
  end

end
