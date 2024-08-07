# frozen_string_literal: true

FactoryBot.define do
  factory :checklist do
    survey { nil }
    sector { nil }
    area { nil }
    max_parties { 1 }
    min_parties { 1 }
    feeder_watch { false }
    on_island { false }
    location { "Location" }
    start_time { "2024-01-01 12:00:00" }
    end_time { "2024-01-01 12:00:00" }
    break_hours { 1.5 }
    hours_foot { 1.5 }
    hours_car { 1.5 }
    hours_boat { 1.5 }
    hours_owling { 1.5 }
    hours_total { 1.5 }
    miles_foot { 1.5 }
    miles_car { 1.5 }
    miles_boat { 1.5 }
    miles_owling { 1.5 }
    miles_total { 1.5 }
  end
end
