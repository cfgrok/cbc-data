# frozen_string_literal: true

require "rails_helper"

RSpec.describe "taxons/new", type: :view do
  before(:each) do
    assign(:taxon, Taxon.new(
      common_name: "MyString",
      cbc_name: "MyString",
      scientific_name: "MyString",
      taxonomic_order: 1,
      generic: false,
      active: false
    ))
  end

  it "renders new taxon form" do
    render

    assert_select "form[action=?][method=?]", taxons_path, "post" do
      assert_select "input[name=?]", "taxon[common_name]"

      assert_select "input[name=?]", "taxon[cbc_name]"

      assert_select "input[name=?]", "taxon[scientific_name]"

      assert_select "input[name=?]", "taxon[taxonomic_order]"

      assert_select "input[name=?]", "taxon[generic]"

      assert_select "input[name=?]", "taxon[active]"
    end
  end
end
