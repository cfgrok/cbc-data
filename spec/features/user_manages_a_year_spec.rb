# frozen_string_literal: true

require "rails_helper"

RSpec.feature "User manages a year", type: :feature, skip: "Ignore" do
  scenario "they can create a year" do
    audubon_year = 199
    vashon_year = 99

    visit root_path
    click_on "years"
    click_on "New Year"

    fill_in "Audubon year", with: audubon_year
    fill_in "Vashon year", with: vashon_year
    click_on "Create Year"

    expect(page).to have_text "Year was successfully created"
    expect(page).to have_text "Audubon year: #{audubon_year}"
    expect(page).to have_text "Vashon year: #{vashon_year}"
  end

  scenario "they can update a year" do
    audubon_year = 199
    vashon_year = 99
    create :year

    visit root_path
    click_on "years"
    click_on "Edit"

    fill_in "Audubon year", with: audubon_year
    fill_in "Vashon year", with: vashon_year
    click_on "Update Year"

    expect(page).to have_text "Year was successfully updated"
    expect(page).to have_text "Audubon year: #{audubon_year}"
    expect(page).to have_text "Vashon year: #{vashon_year}"
  end
end
