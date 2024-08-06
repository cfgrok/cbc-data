# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /years", type: :request, skip: "Skip this for now..." do
  it "displays a list of years" do
    year1 = create :year
    year2 = create :year, audubon_year: 199, vashon_year: 99

    get years_path

    expect(response).to render_template :index
    expect(response.body).to match %r{<td>#{year1.audubon_year}</td>\s+<td>#{year1.vashon_year}</td>}
    expect(response.body).to match %r{<td>#{year2.audubon_year}</td>\s+<td>#{year2.vashon_year}</td>}
  end

  it "displays the new year form" do
    get new_year_path

    expect(response).to render_template :new
  end

  it "creates a year" do
    year_params = attributes_for :year

    expect { post years_path, year: year_params }.to change { Year.count }.by 1

    expect(response).to redirect_to assigns(:year)
    follow_redirect!

    expect(response).to render_template :show
    expect(response.body).to include "Year was successfully created."
    expect_assigns_values year_params[:audubon_year], year_params[:vashon_year]
  end

  it "does not create an invalid year" do
    year_params = attributes_for :year, audubon_year: "", vashon_year: ""

    expect { post years_path, year: year_params }.not_to(change { Year.count })

    expect(response).to render_template :new
    expect(response.body).to include "Audubon year can&#39;t be blank"
    expect(response.body).to include "Vashon year can&#39;t be blank"
  end

  it "displays the year" do
    year = create :year

    get year_path(year.id)

    expect(response).to render_template :show
    expect_assigns_values year.audubon_year, year.vashon_year
  end

  it "displays the year edit form" do
    year = create :year

    get edit_year_path(year.id)

    expect(response).to render_template :edit
    expect_assigns_values year.audubon_year, year.vashon_year
  end
end

def expect_assigns_values(audubon_year, vashon_year)
  expect(assigns(:year).audubon_year).to eq audubon_year
  expect(assigns(:year).vashon_year).to eq vashon_year
end
