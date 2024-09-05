# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observations/new", type: :view do
  it "renders new observation form" do
    assign(:observation, Observation.new(
      number: 1,
      taxon: create(:taxon),
      checklist: checklist,
      count_week: false,
      notes: "MyString",
      survey: survey,
      sector: sector
    ))

    render

    expect(rendered).to have_form_field observations_path, "observation[number]", "1"
    expect(rendered).to have_form_select observations_path, "observation[taxon_id]", "MyString"
    expect(rendered).to have_form_select observations_path, "observation[checklist_id]", "1: Sector Code - Area Name"
    expect(rendered).to have_form_checked observations_path, "observation[count_week]", false
    expect(rendered).to have_form_field observations_path, "observation[notes]", "MyString"
  end
end

def area
  @area ||= create(:area, sector: sector)
end

def checklist
  @checklist ||= create(
    :checklist,
    area: area,
    survey: survey,
    sector: sector
  )
end

def sector
  @sector ||= create(:sector)
end

def survey
  @survey ||= create(
    :survey,
    year: create(:year)
  )
end
