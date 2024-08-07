# frozen_string_literal: true

FactoryBot.define do
  factory :observation do
    number { 1 }
    taxon { nil }
    checklist { nil }
    count_week { false }
    notes { "MyString" }
    survey { nil }
    sector { nil }
  end
end
