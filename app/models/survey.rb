class Survey < ActiveRecord::Base
  include Summarizable

  belongs_to :year
  has_many :checklists

  has_many :observations, -> { joins(:taxon).includes(:taxon).order('taxons.taxonomic_order') }, through: :checklists

  validates :year, presence: true

  delegate :to_s, to: :year

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
end
