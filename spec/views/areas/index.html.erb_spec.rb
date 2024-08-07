# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas/index", type: :view do
  before(:each) do
    assign(:areas, [
      Area.create!(
        name: "Area Name",
        on_island: false,
        sector: Sector.create!(name: "Sector Name")
      ),
      Area.create!(
        name: "Area Name",
        on_island: false,
        sector: Sector.create!(name: "Sector Name")
      )
    ])
  end

  it "renders a list of areas" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("Area Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Sector Name".to_s), count: 2
  end
end
