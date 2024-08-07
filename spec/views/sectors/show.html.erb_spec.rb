# frozen_string_literal: true

require "rails_helper"

RSpec.describe "sectors/show", type: :view do
  before(:each) do
    assign(:sector, Sector.create!(
      name: "Name",
      code: "Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Code/)
  end
end
