# frozen_string_literal: true

require "rails_helper"

RSpec.describe "checklists/show", type: :view do
  before(:each) do
    assign(:checklist, create(
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
      miles_total: 14.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match field_in_p("Survey", survey)
    expect(rendered).to match field_in_p("Sector", sector)
    expect(rendered).to match field_in_p("Area", area)
    expect(rendered).to match field_in_p("Max parties", 2)
    expect(rendered).to match field_in_p("Min parties", 3)
    expect(rendered).to match field_in_p("Feeder watch", "false")
    expect(rendered).to match field_in_p("Location", "Location")
    expect(rendered).to match field_in_p("Break hours", 4.5)
    expect(rendered).to match field_in_p("Hours foot", 5.5)
    expect(rendered).to match field_in_p("Hours car", 6.5)
    expect(rendered).to match field_in_p("Hours boat", 7.5)
    expect(rendered).to match field_in_p("Hours owling", 8.5)
    expect(rendered).to match field_in_p("Hours total", 9.5)
    expect(rendered).to match field_in_p("Miles foot", 10.5)
    expect(rendered).to match field_in_p("Miles car", 11.5)
    expect(rendered).to match field_in_p("Miles boat", 12.5)
    expect(rendered).to match field_in_p("Miles owling", 13.5)
    expect(rendered).to match field_in_p("Miles total", 14.5)
  end
end

def field_in_p(label, value)
  %r{<p>\s*<strong>#{label}:</strong>\s+#{value}\s*</p>}
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
