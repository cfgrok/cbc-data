# frozen_string_literal: true

require "rails_helper"

RSpec.describe "surveys/index", type: :view do
  before do
    assign(:surveys, [
      create(:survey, year: create(:year)),
      create(:survey, year: create(:year)),
    ])
  end

  it "renders a list of surveys" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new(1.to_s), count: 4
  end
end
