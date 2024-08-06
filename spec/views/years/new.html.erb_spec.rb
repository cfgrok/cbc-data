# frozen_string_literal: true

require "rails_helper"

RSpec.describe "years/new", type: :view do
  before(:each) do
    assign(:year, Year.new(
      audubon_year: 1,
      vashon_year: 1
    ))
  end

  it "renders new year form" do
    render

    assert_select "form[action=?][method=?]", years_path, "post" do
      assert_select "input[name=?]", "year[audubon_year]"

      assert_select "input[name=?]", "year[vashon_year]"
    end
  end
end
