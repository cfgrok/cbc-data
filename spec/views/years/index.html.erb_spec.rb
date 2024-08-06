# frozen_string_literal: true

require "rails_helper"

RSpec.describe "years/index", type: :view do
  before(:each) do
    assign(:years, [
      Year.create!(
        audubon_year: 2,
        vashon_year: 3
      ),
      Year.create!(
        audubon_year: 2,
        vashon_year: 3
      )
    ])
  end

  it "renders a list of years" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
