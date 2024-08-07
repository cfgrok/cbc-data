# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observers/show", type: :view do
  before(:each) do
    assign(:observer, Observer.create!(
      first_name: "First Name",
      last_name: "Last Name",
      email: "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
  end
end
