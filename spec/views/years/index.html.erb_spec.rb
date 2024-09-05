# frozen_string_literal: true

require "rails_helper"

RSpec.describe "years/index", type: :view do
  it "renders a list of years" do
    year1 = build_stubbed :year, audubon_year: 1, vashon_year: 2
    year2 = build_stubbed :year, audubon_year: 3, vashon_year: 4
    assign :years, [year1, year2]

    render

    expect(rendered).to have_index_view_row "audubon_year", "1"
    expect(rendered).to have_index_view_row "vashon_year", "2"
    expect(rendered).to have_index_view_row "audubon_year", "3"
    expect(rendered).to have_index_view_row "vashon_year", "4"
  end
end
