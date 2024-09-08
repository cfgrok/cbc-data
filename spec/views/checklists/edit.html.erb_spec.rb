# frozen_string_literal: true

require "rails_helper"

RSpec.describe "checklists/edit", type: :view do
  it "renders the edit checklist form" do
    sector = create(:sector)
    checklist = create(
      :checklist,
      survey: create(
        :survey,
        year: create(:year),
      ),
      sector: sector,
      area: create(:area, sector: sector),
      max_parties: 1,
      min_parties: 1,
      feeder_watch: 1,
      location: "Location",
      start_time: "18:00",
      end_time: "19:30",
      break_hours: 1,
      hours_foot: 1,
      hours_car: 1,
      hours_boat: 1,
      hours_owling: 1,
      hours_total: 1,
      miles_foot: 1,
      miles_car: 1,
      miles_boat: 1,
      miles_owling: 1,
      miles_total: 1,
    )
    observer1 = create(:observer, first_name: "First", last_name: "Observer")
    observer2 = create(:observer, first_name: "Second", last_name: "Observer")
    checklist.observers << observer1
    checklist.observers << observer2
    assign :checklist, checklist

    render

    expect(rendered).to have_form_select checklist_path(checklist), "checklist[survey_id]", "1"
    expect(rendered).to have_form_select checklist_path(checklist), "checklist[sector_id]", "Sector Name"
    expect(rendered).to have_form_select checklist_path(checklist), "checklist[area_id]", "Sector Code - Area Name"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[max_parties]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[min_parties]", "1"
    expect(rendered).to have_form_checked checklist_path(checklist), "checklist[feeder_watch]", true
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[location]", "Location"
    expect(rendered).to have_form_select checklist_path(checklist), "checklist[start_time(4i)]", "18"
    expect(rendered).to have_form_select checklist_path(checklist), "checklist[start_time(5i)]", "00"
    expect(rendered).to have_form_select checklist_path(checklist), "checklist[end_time(4i)]", "19"
    expect(rendered).to have_form_select checklist_path(checklist), "checklist[end_time(5i)]", "30"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[break_hours]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[hours_foot]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[hours_car]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[hours_boat]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[hours_owling]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[hours_total]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[miles_foot]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[miles_car]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[miles_boat]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[miles_owling]", "1"
    expect(rendered).to have_form_field checklist_path(checklist), "checklist[miles_total]", "1"
    expect(rendered).to have_form_select checklist_path(checklist), "checklist[observer_ids][]", ["First Observer", "Second Observer"]
  end
end
