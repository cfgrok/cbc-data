# frozen_string_literal: true

require "rails_helper"

RSpec.describe "years/edit", type: :view do
  let(:year) do
    Year.create!(
      audubon_year: 1,
      vashon_year: 1
    )
  end

  before(:each) do
    assign(:year, year)
  end

  it "renders the edit year form" do
    render

    assert_select "form[action=?][method=?]", year_path(year), "post" do
      assert_select "input[name=?]", "year[audubon_year]"

      assert_select "input[name=?]", "year[vashon_year]"
    end
  end
end
