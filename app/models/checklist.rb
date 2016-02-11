class Checklist < ActiveRecord::Base
  include Summarizable

  belongs_to :survey
  belongs_to :sector
  belongs_to :area

  has_many :observations, -> { joins(:taxon).order('taxons.taxonomic_order') }, dependent: :destroy

  accepts_nested_attributes_for :observations, allow_destroy: true

  has_and_belongs_to_many :observers, -> { order 'last_name, first_name' }

  def to_s
    "#{survey.to_s}: #{area.to_s}"
  end

  def rows
    @row_observations ||= observations
    @rows ||= Taxon.all.map do |taxon|
      Row.new(taxon, @row_observations.find {|o| o.taxon == taxon})
    end
  end
end
