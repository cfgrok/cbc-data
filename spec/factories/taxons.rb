# frozen_string_literal: true

FactoryBot.define do
  factory :taxon do
    common_name { "MyString" }
    cbc_name { "MyString" }
    scientific_name { "MyString" }
    taxonomic_order { 1 }
    generic { false }
    active { false }
  end
end
