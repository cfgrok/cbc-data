# frozen_string_literal: true

require "rails_helper"

RSpec.describe "checklists/index", type: :view do
  before(:each) do
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
      miles_total: 14.5
    )
    assign(:checklists, [
      checklist,
      checklist
    ])
  end

  it "renders a list of checklists" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("^#{survey}$"), count: 2
    assert_select cell_selector, text: Regexp.new(sector.name), count: 2
    assert_select cell_selector, text: Regexp.new(area.name), count: 2
    assert_select cell_selector, text: Regexp.new("^2$"), count: 2
    assert_select cell_selector, text: Regexp.new("^3$"), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Location"), count: 2
    assert_select cell_selector, text: Regexp.new("^4.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^5.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^6.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^7.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^8.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^9.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^10.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^11.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^12.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^13.5$"), count: 2
    assert_select cell_selector, text: Regexp.new("^14.5$"), count: 2
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
