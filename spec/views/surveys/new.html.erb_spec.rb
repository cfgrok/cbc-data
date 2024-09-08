# frozen_string_literal: true

require "rails_helper"

RSpec.describe "surveys/new", type: :view do
  before do
    assign(:survey, Survey.new(
      year: nil,
    ))
  end

  it "renders new survey form" do
    render

    assert_select "form[action=?][method=?]", surveys_path, "post" do
      assert_select "select[name=?]", "survey[year_id]"
    end
  end
end
