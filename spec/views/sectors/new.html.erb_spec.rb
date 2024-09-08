# frozen_string_literal: true

require "rails_helper"

RSpec.describe "sectors/new", type: :view do
  before do
    assign(:sector, Sector.new(
      name: "MyString",
      code: "MyString",
    ))
  end

  it "renders new sector form" do
    render

    assert_select "form[action=?][method=?]", sectors_path, "post" do
      assert_select "input[name=?]", "sector[name]"

      assert_select "input[name=?]", "sector[code]"
    end
  end
end
