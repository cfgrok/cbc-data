# frozen_string_literal: true

FactoryBot.define do
  factory :area do
    name { "Area Name" }
    on_island { false }
    sector { nil }
  end
end
