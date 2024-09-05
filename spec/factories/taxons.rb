# frozen_string_literal: true

FactoryBot.define do
  factory :taxon do
    common_name { "Common Name" }
    cbc_name { "CBC Name" }
    scientific_name { "Scientific Name" }
    sequence(:taxonomic_order)
  end
end
