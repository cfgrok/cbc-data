# frozen_string_literal: true

require "rails_helper"

RSpec.describe "years/show", type: :view do
  before(:each) do
    assign(:year, Year.create!(
      audubon_year: 2,
      vashon_year: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
