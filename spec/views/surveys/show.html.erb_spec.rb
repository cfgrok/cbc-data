# frozen_string_literal: true

require "rails_helper"

RSpec.describe "surveys/show", type: :view do
  before(:each) do
    assign(:survey, create(:survey, year: create(:year)))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
