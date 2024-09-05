# frozen_string_literal: true

require "rails_helper"

RSpec.describe "checklists/new", type: :view do
  it "renders new checklist form" do
    sector = create(:sector)
    assign(:checklist, Checklist.new(
      survey: create(:survey, year: create(:year)),
      sector: sector,
      area: create(:area, sector: sector),
      max_parties: 1,
      min_parties: 1,
      feeder_watch: false,
      location: "MyString",
      start_time: "12:00",
      end_time: "13:00",
      break_hours: 1.5,
      hours_foot: 1.5,
      hours_car: 1.5,
      hours_boat: 1.5,
      hours_owling: 1.5,
      hours_total: 1.5,
      miles_foot: 1.5,
      miles_car: 1.5,
      miles_boat: 1.5,
      miles_owling: 1.5,
      miles_total: 1.5
    ))

    render

    expect(rendered).to have_form_select checklists_path, "checklist[survey_id]", "1"
    expect(rendered).to have_form_select checklists_path, "checklist[sector_id]", "Sector Name"
    expect(rendered).to have_form_select checklists_path, "checklist[area_id]", "Sector Code - Area Name"
    expect(rendered).to have_form_field checklists_path, "checklist[max_parties]", "1"
    expect(rendered).to have_form_field checklists_path, "checklist[min_parties]", "1"
    expect(rendered).to have_form_checked checklists_path, "checklist[feeder_watch]", false
    expect(rendered).to have_form_field checklists_path, "checklist[location]", "MyString"
    expect(rendered).to have_form_select checklists_path, "checklist[start_time(4i)]", "12"
    expect(rendered).to have_form_select checklists_path, "checklist[start_time(5i)]", "00"
    expect(rendered).to have_form_select checklists_path, "checklist[end_time(4i)]", "13"
    expect(rendered).to have_form_select checklists_path, "checklist[end_time(5i)]", "00"
    expect(rendered).to have_form_field checklists_path, "checklist[break_hours]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[hours_foot]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[hours_car]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[hours_boat]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[hours_owling]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[hours_total]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[miles_foot]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[miles_car]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[miles_boat]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[miles_owling]", "1.5"
    expect(rendered).to have_form_field checklists_path, "checklist[miles_total]", "1.5"
  end
end
