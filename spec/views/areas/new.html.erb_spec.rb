# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas/new", type: :view do
  before(:each) do
    assign(:area, Area.new(
      name: "MyString",
      on_island: false,
      sector: nil
    ))
  end

  it "renders new area form" do
    render

    assert_select "form[action=?][method=?]", areas_path, "post" do
      assert_select "input[name=?]", "area[name]"

      assert_select "select[name=?]", "area[sector_id]"
    end
  end
end
