# frozen_string_literal: true

require "rails_helper"

RSpec.describe "years/edit", type: :view do
  it "renders the edit year form" do
    year = build_stubbed(:year)
    assign :year, year

    render

    expect(rendered).to have_form_field year_path(year), "year[audubon_year]", "1"
    expect(rendered).to have_form_field year_path(year), "year[vashon_year]", "1"
  end
end
