# frozen_string_literal: true

FactoryBot.define do
  factory :sector do
    name { "Sector Name" }
    code { "Sector Code" }
    on_island { false }
  end
end
