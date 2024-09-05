# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas/show", type: :view do
  it "renders attributes in <p>" do
    assign :area, build_stubbed(:area, sector: build_stubbed(:sector))

    render

    expect(rendered).to have_p_with_label "Name", "Area Name"
    expect(rendered).to have_p_with_label "Sector", "Sector Name"
  end
end
