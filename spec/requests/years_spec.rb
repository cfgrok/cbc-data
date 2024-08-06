# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/years", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      create :year
      get years_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      year = create :year
      get year_url(year)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_year_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      year = create :year
      get edit_year_url(year)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Year" do
        expect do
          post years_url, year: attributes_for(:year)
        end.to change(Year, :count).by(1)
      end

      it "redirects to the created year" do
        post years_url, year: attributes_for(:year)
        expect(response).to redirect_to(year_url(Year.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Year" do
        expect do
          post years_url, year: year_attributes(0, 0)
        end.to change(Year, :count).by(0)
        expect do
          post years_url, year: year_attributes(1.1, 1.1)
        end.to change(Year, :count).by(0)
        expect do
          post years_url, year: year_attributes("", "")
        end.to change(Year, :count).by(0)
        expect do
          post years_url, year: year_attributes("string", "string")
        end.to change(Year, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post years_url, year: year_attributes("", "")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested year" do
        year = create :year
        patch year_url(year), year: year_attributes(2, 2)
        year.reload
        expect(year.audubon_year).to eq 2
        expect(year.vashon_year).to eq 2
      end

      it "redirects to the year" do
        year = create :year
        patch year_url(year), year: attributes_for(:year)
        expect(response).to redirect_to(year_url(year))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        year = create :year
        patch year_url(year), year: year_attributes("", "")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested year" do
      year = create :year
      expect do
        delete year_url(year)
      end.to change(Year, :count).by(-1)
    end

    it "redirects to the years list" do
      year = create :year
      delete year_url(year)
      expect(response).to redirect_to(years_url)
    end
  end
end

def year_attributes(audubon_year, vashon_year)
  attributes_for :year, audubon_year: audubon_year, vashon_year: vashon_year
end
