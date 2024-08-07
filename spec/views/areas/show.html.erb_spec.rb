# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas/show", type: :view do
  before(:each) do
    assign(:area, Area.create!(
      name: "Area Name",
      on_island: false,
      sector: Sector.create!(name: "Sector Name")
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Area Name/)
    expect(rendered).to match(/Sector Name/)
  end
end
