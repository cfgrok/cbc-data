# frozen_string_literal: true

require "rails_helper"

RSpec.describe "taxons/index", type: :view do
  before do
    assign(:taxons, [
      Taxon.create!(
        common_name: "Common Name",
        cbc_name: "Cbc Name",
        scientific_name: "Scientific Name",
        taxonomic_order: 1,
        generic: false,
        active: false,
      ),
      Taxon.create!(
        common_name: "Common Name",
        cbc_name: "Cbc Name",
        scientific_name: "Scientific Name",
        taxonomic_order: 2,
        generic: false,
        active: false,
      ),
    ])
  end

  it "renders a list of taxons" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("Common Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cbc Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Scientific Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(1.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 4
  end
end
