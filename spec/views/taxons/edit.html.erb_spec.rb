# frozen_string_literal: true

require "rails_helper"

RSpec.describe "taxons/edit", type: :view do
  let(:taxon) do
    Taxon.create!(
      common_name: "MyString",
      cbc_name: "MyString",
      scientific_name: "MyString",
      taxonomic_order: 1,
      generic: false,
      active: false,
    )
  end

  before do
    assign(:taxon, taxon)
  end

  it "renders the edit taxon form" do
    render

    assert_select "form[action=?][method=?]", taxon_path(taxon), "post" do
      assert_select "input[name=?]", "taxon[common_name]"

      assert_select "input[name=?]", "taxon[cbc_name]"

      assert_select "input[name=?]", "taxon[scientific_name]"

      assert_select "input[name=?]", "taxon[taxonomic_order]"

      assert_select "input[name=?]", "taxon[generic]"

      assert_select "input[name=?]", "taxon[active]"
    end
  end
end
