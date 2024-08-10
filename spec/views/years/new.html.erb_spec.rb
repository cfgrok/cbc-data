# frozen_string_literal: true

require "rails_helper"

RSpec.describe "years/new", type: :view do
  it "renders new year form" do
    assign :year, Year.new(audubon_year: 2, vashon_year: 3)

    render

    expect(rendered).to have_form_field years_path, "year[audubon_year]", 2
    expect(rendered).to have_form_field years_path, "year[vashon_year]", 3
  end
end
