# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observations/index", type: :view do
  before(:each) do
    assign(:observations, [
      create(
        :observation,
        number: 2,
        taxon: taxon,
        checklist: checklist,
        count_week: false,
        notes: "Notes",
        survey: survey,
        sector: sector
      ),
      create(
        :observation,
        number: 2,
        taxon: taxon,
        checklist: checklist,
        count_week: false,
        notes: "Notes",
        survey: survey,
        sector: sector
      )
    ])
  end

  it "renders a list of observations" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(taxon.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(checklist.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Notes".to_s), count: 2
  end
end

def taxon
  @taxon ||= create :taxon
end

def checklist
  @checklist ||= create :checklist, survey: survey, sector: sector, area: create(:area, sector: sector)
end

def survey
  @survey ||= create :survey, year: create(:year)
end

def sector
  @sector ||= create :sector
end
