# frozen_string_literal: true

require "rails_helper"

RSpec.describe "taxons/show", type: :view do
  before(:each) do
    assign(:taxon, Taxon.create!(
      common_name: "Common Name",
      cbc_name: "Cbc Name",
      scientific_name: "Scientific Name",
      taxonomic_order: 2,
      generic: false,
      active: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Common Name/)
    expect(rendered).to match(/Cbc Name/)
    expect(rendered).to match(/Scientific Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
