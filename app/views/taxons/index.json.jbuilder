# frozen_string_literal: true

json.array!(@taxons) do |taxon|
  json.extract! taxon, :id, :common_name, :cbc_name, :scientific_name, :taxonomic_order, :generic, :active
  json.url taxon_url(taxon, format: :json)
end
