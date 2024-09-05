# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas/new", type: :view do
  it "renders new area form" do
    assign :area, Area.new(name: "Area Name", sector: create(:sector, name: "Sector Name"))

    render

    expect(rendered).to have_form_field areas_path, "area[name]", "Area Name"
    expect(rendered).to have_form_select areas_path, "area[sector_id]", "Sector Name"
  end
end
