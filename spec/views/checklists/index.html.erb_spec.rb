# frozen_string_literal: true

require "rails_helper"

RSpec.describe "checklists/index", type: :view do
  it "renders a list of checklists" do
    checklist = create(
      :checklist,
      survey: survey,
      sector: sector,
      area: area,
      max_parties: 2,
      min_parties: 3,
      feeder_watch: false,
      location: "Location",
      break_hours: 4.5,
      hours_foot: 5.5,
      hours_car: 6.5,
      hours_boat: 7.5,
      hours_owling: 8.5,
      hours_total: 9.5,
      miles_foot: 10.5,
      miles_car: 11.5,
      miles_boat: 12.5,
      miles_owling: 13.5,
      miles_total: 14.5,
    )
    assign(:checklists, [
      checklist,
      checklist,
    ])

    render

    expect(rendered).to have_index_view_row "survey", "1", 2
    expect(rendered).to have_index_view_row "sector", "Sector Name", 2
    expect(rendered).to have_index_view_row "area", "Sector Code - Area Name", 2
    expect(rendered).to have_index_view_row "max_parties", "2", 2
    expect(rendered).to have_index_view_row "min_parties", "3", 2
    expect(rendered).to have_index_view_row "feeder_watch", "false", 2
    expect(rendered).to have_index_view_row "location", "Location", 2
    expect(rendered).to have_index_view_row "break_hours", "4.5", 2
    expect(rendered).to have_index_view_row "hours_foot", "5.5", 2
    expect(rendered).to have_index_view_row "hours_car", "6.5", 2
    expect(rendered).to have_index_view_row "hours_boat", "7.5", 2
    expect(rendered).to have_index_view_row "hours_owling", "8.5", 2
    expect(rendered).to have_index_view_row "hours_total", "9.5", 2
    expect(rendered).to have_index_view_row "miles_foot", "10.5", 2
    expect(rendered).to have_index_view_row "miles_car", "11.5", 2
    expect(rendered).to have_index_view_row "miles_boat", "12.5", 2
    expect(rendered).to have_index_view_row "miles_owling", "13.5", 2
    expect(rendered).to have_index_view_row "miles_total", "14.5", 2
  end
end

def survey
  @survey ||= create :survey, year: create(:year)
end

def sector
  @sector ||= create :sector
end

def area
  @area ||= create :area, sector: sector
end
