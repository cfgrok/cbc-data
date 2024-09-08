# frozen_string_literal: true

require "rails_helper"

RSpec.describe "surveys/edit", type: :view do
  let(:survey) do
    create :survey, year: create(:year)
  end

  before do
    assign(:survey, survey)
  end

  it "renders the edit survey form" do
    render

    assert_select "form[action=?][method=?]", survey_path(survey), "post" do
      assert_select "select[name=?]", "survey[year_id]"
    end
  end
end
