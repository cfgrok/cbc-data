# frozen_string_literal: true

module TaxonMapping
  extend ActiveSupport::Concern

  def map_taxon_in_row(row, index)
    @ebird_taxon_mapping ||= Rails.configuration.cbc[:ebird_taxon_mapping]

    return unless (taxon_mapping = @ebird_taxon_mapping.fetch(row[index], nil))

    row[index] = taxon_mapping
  end
end
