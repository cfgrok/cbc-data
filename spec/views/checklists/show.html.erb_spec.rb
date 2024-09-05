# frozen_string_literal: true

require "rails_helper"

RSpec.describe "checklists/show", type: :view do
  it "renders attributes in <p>" do
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

    render

    expect(rendered).to have_p_with_label "Survey", survey
    expect(rendered).to have_p_with_label "Sector", sector
    expect(rendered).to have_p_with_label "Area", area
    expect(rendered).to have_p_with_label "Max parties", "2"
    expect(rendered).to have_p_with_label "Min parties", "3"
    expect(rendered).to have_p_with_label "Feeder watch", "false"
    expect(rendered).to have_p_with_label "Location", "Location"
    expect(rendered).to have_p_with_label "Break hours", "4.5"
    expect(rendered).to have_p_with_label "Hours foot", "5.5"
    expect(rendered).to have_p_with_label "Hours car", "6.5"
    expect(rendered).to have_p_with_label "Hours boat", "7.5"
    expect(rendered).to have_p_with_label "Hours owling", "8.5"
    expect(rendered).to have_p_with_label "Hours total", "9.5"
    expect(rendered).to have_p_with_label "Miles foot", "10.5"
    expect(rendered).to have_p_with_label "Miles car", "11.5"
    expect(rendered).to have_p_with_label "Miles boat", "12.5"
    expect(rendered).to have_p_with_label "Miles owling", "13.5"
    expect(rendered).to have_p_with_label "Miles total", "14.5"
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
