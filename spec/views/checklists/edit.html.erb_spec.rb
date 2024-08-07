# frozen_string_literal: true

require "rails_helper"

RSpec.describe "checklists/edit", type: :view do
  let(:checklist) do
    Checklist.create!(
      survey: nil,
      sector: nil,
      area: nil,
      max_parties: 1,
      min_parties: 1,
      feeder_watch: false,
      location: "MyString",
      break_hours: 1.5,
      hours_foot: 1.5,
      hours_car: 1.5,
      hours_boat: 1.5,
      hours_owling: 1.5,
      hours_total: 1.5,
      miles_foot: 1.5,
      miles_car: 1.5,
      miles_boat: 1.5,
      miles_owling: 1.5,
      miles_total: 1.5
    )
  end

  before(:each) do
    assign(:checklist, checklist)
  end

  it "renders the edit checklist form" do
    render

    assert_select "form[action=?][method=?]", checklist_path(checklist), "post" do
      assert_select "select[name=?]", "checklist[survey_id]"

      assert_select "select[name=?]", "checklist[sector_id]"

      assert_select "select[name=?]", "checklist[area_id]"

      assert_select "input[name=?]", "checklist[max_parties]"

      assert_select "input[name=?]", "checklist[min_parties]"

      assert_select "input[name=?]", "checklist[feeder_watch]"

      assert_select "input[name=?]", "checklist[location]"

      assert_select "input[name=?]", "checklist[break_hours]"

      assert_select "input[name=?]", "checklist[hours_foot]"

      assert_select "input[name=?]", "checklist[hours_car]"

      assert_select "input[name=?]", "checklist[hours_boat]"

      assert_select "input[name=?]", "checklist[hours_owling]"

      assert_select "input[name=?]", "checklist[hours_total]"

      assert_select "input[name=?]", "checklist[miles_foot]"

      assert_select "input[name=?]", "checklist[miles_car]"

      assert_select "input[name=?]", "checklist[miles_boat]"

      assert_select "input[name=?]", "checklist[miles_owling]"

      assert_select "input[name=?]", "checklist[miles_total]"
    end
  end
end
