# frozen_string_literal: true

require "rails_helper"

RSpec.describe "sectors/edit", type: :view do
  let(:sector) do
    Sector.create!(
      name: "MyString",
      code: "MyString"
    )
  end

  before(:each) do
    assign(:sector, sector)
  end

  it "renders the edit sector form" do
    render

    assert_select "form[action=?][method=?]", sector_path(sector), "post" do
      assert_select "input[name=?]", "sector[name]"

      assert_select "input[name=?]", "sector[code]"
    end
  end
end
