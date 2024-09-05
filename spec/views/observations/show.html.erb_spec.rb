# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observations/show", type: :view do
  it "renders attributes in <p>" do
    assign(:observation, Observation.create!(
      number: 2,
      taxon: nil,
      checklist: nil,
      count_week: false,
      notes: "Notes",
      survey: nil,
      sector: nil
    ))

    render

    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
