# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observations/edit", type: :view do
  it "renders the edit observation form" do
    observation = create(
      :observation,
      number: 1,
      taxon: create(:taxon),
      checklist: checklist,
      count_week: false,
      notes: "MyString",
      survey: survey,
      sector: sector,
    )
    assign :observation, observation

    render

    expect(rendered).to have_form_field observation_path(observation), "observation[number]", "1"
    expect(rendered).to have_form_select observation_path(observation), "observation[taxon_id]", "MyString"
    expect(rendered).to have_form_select observation_path(observation), "observation[checklist_id]", "1: Sector Code - Area Name"
    expect(rendered).to have_form_checked observation_path(observation), "observation[count_week]", false
    expect(rendered).to have_form_field observation_path(observation), "observation[notes]", "MyString"
  end
end

def checklist
  @checklist ||= create(
    :checklist,
    survey: survey,
    sector: sector,
  )
end

def sector
  @sector ||= create(:sector)
end

def survey
  @survey ||= create(
    :survey,
    year: create(:year),
  )
end
