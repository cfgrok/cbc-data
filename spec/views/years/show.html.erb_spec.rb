# frozen_string_literal: true

require "rails_helper"

RSpec.describe "years/show", type: :view do
  it "renders attributes in <p>" do
    assign :year, build_stubbed(:year)

    render

    expect(rendered).to have_p_with_label "Audubon year", 1
    expect(rendered).to have_p_with_label "Vashon year", 1
  end
end
