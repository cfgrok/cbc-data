# frozen_string_literal: true

require "rails_helper"

RSpec.describe "sectors/index", type: :view do
  before do
    assign(:sectors, [
      Sector.create!(
        name: "Name",
        code: "Code",
      ),
      Sector.create!(
        name: "Name",
        code: "Code",
      ),
    ])
  end

  it "renders a list of sectors" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Code".to_s), count: 2
  end
end
