# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observers/index", type: :view do
  before(:each) do
    assign(:observers, [
      Observer.create!(
        first_name: "First Name",
        last_name: "Last Name",
        email: "Email"
      ),
      Observer.create!(
        first_name: "First Name",
        last_name: "Last Name",
        email: "Email"
      )
    ])
  end

  it "renders a list of observers" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("First Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Last Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
  end
end
