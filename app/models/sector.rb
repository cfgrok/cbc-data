class Sector < ActiveRecord::Base
  include Summarizable

  has_many :areas
  has_many :checklists

  has_many :observations, -> { joins(:taxon).order('taxons.taxonomic_order') }, through: :checklists

  def to_s
    name
  end
end
