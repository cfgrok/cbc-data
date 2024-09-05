# frozen_string_literal: true

FactoryBot.define do
  factory :observation do
    number { 1 }
    taxon
    checklist
    count_week { false }
    survey
    sector
  end
end
