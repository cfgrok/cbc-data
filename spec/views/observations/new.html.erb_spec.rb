# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observations/new", type: :view do
  before(:each) do
    assign(:observation, Observation.new(
      number: 1,
      taxon: nil,
      checklist: nil,
      count_week: false,
      notes: "MyString",
      survey: nil,
      sector: nil
    ))
  end

  it "renders new observation form" do
    render

    assert_select "form[action=?][method=?]", observations_path, "post" do
      assert_select "input[name=?]", "observation[number]"

      assert_select "select[name=?]", "observation[taxon_id]"

      assert_select "select[name=?]", "observation[checklist_id]"

      assert_select "input[name=?]", "observation[count_week]"

      assert_select "input[name=?]", "observation[notes]"
    end
  end
end
