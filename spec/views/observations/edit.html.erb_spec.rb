# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observations/edit", type: :view do
  let(:observation) do
    Observation.create!(
      number: 1,
      taxon: nil,
      checklist: nil,
      count_week: false,
      notes: "MyString",
      survey: nil,
      sector: nil
    )
  end

  before(:each) do
    assign(:observation, observation)
  end

  it "renders the edit observation form" do
    render

    assert_select "form[action=?][method=?]", observation_path(observation), "post" do
      assert_select "input[name=?]", "observation[number]"

      assert_select "select[name=?]", "observation[taxon_id]"

      assert_select "select[name=?]", "observation[checklist_id]"

      assert_select "input[name=?]", "observation[count_week]"

      assert_select "input[name=?]", "observation[notes]"
    end
  end
end
