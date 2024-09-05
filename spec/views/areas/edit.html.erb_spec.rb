# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas/edit", type: :view do
  it "renders the edit area form" do
    area = build_stubbed :area, sector: create(:sector)
    assign :area, area

    render

    expect(rendered).to have_form_field area_path(area), "area[name]", "Area Name"
    expect(rendered).to have_form_select area_path(area), "area[sector_id]", "Sector Name"
  end
end
