# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas/edit", type: :view do
  let(:area) do
    Area.create!(
      name: "MyString",
      on_island: false,
      sector: nil
    )
  end

  before(:each) do
    assign(:area, area)
  end

  it "renders the edit area form" do
    render

    assert_select "form[action=?][method=?]", area_path(area), "post" do
      assert_select "input[name=?]", "area[name]"

      assert_select "select[name=?]", "area[sector_id]"
    end
  end
end
