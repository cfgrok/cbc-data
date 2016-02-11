class Survey < ActiveRecord::Base
  include Summarizable

  belongs_to :year
  has_many :checklists

  has_many :observations, -> { joins(:taxon).order('taxons.taxonomic_order') }, through: :checklists

  validates :year, presence: true

  delegate :to_s, to: :year
end
