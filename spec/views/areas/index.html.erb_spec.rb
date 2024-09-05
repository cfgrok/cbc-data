# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas/index", type: :view do
  it "renders a list of areas" do
    area1 = build_stubbed :area, name: "Area Name 1", sector: Sector.new(name: "Sector Name 1")
    area2 = build_stubbed :area, name: "Area Name 2", sector: Sector.new(name: "Sector Name 2")
    assign :areas, [area1, area2]

    render

    expect(rendered).to have_index_view_row "name", "Area Name 1"
    expect(rendered).to have_index_view_row "sector", "Sector Name 1"
    expect(rendered).to have_index_view_row "name", "Area Name 2"
    expect(rendered).to have_index_view_row "sector", "Sector Name 2"
  end
end
