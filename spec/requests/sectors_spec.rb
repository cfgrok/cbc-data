# frozen_string_literal: true

require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/sectors", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Sector. As you add validations to Sector, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip("Add a hash of attributes valid for your model")
  end

  let(:invalid_attributes) do
    skip("Add a hash of attributes invalid for your model")
  end

  describe "GET /index" do
    it "renders a successful response" do
      Sector.create! valid_attributes
      get sectors_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      sector = Sector.create! valid_attributes
      get sector_url(sector)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_sector_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      sector = Sector.create! valid_attributes
      get edit_sector_url(sector)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Sector" do
        expect do
          post sectors_url, params: { sector: valid_attributes }
        end.to change(Sector, :count).by(1)
      end

      it "redirects to the created sector" do
        post sectors_url, params: { sector: valid_attributes }
        expect(response).to redirect_to(sector_url(Sector.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Sector" do
        expect do
          post sectors_url, params: { sector: invalid_attributes }
        end.to change(Sector, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post sectors_url, params: { sector: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        skip("Add a hash of attributes valid for your model")
      end

      it "updates the requested sector" do
        sector = Sector.create! valid_attributes
        patch sector_url(sector), params: { sector: new_attributes }
        sector.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the sector" do
        sector = Sector.create! valid_attributes
        patch sector_url(sector), params: { sector: new_attributes }
        sector.reload
        expect(response).to redirect_to(sector_url(sector))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        sector = Sector.create! valid_attributes
        patch sector_url(sector), params: { sector: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested sector" do
      sector = Sector.create! valid_attributes
      expect do
        delete sector_url(sector)
      end.to change(Sector, :count).by(-1)
    end

    it "redirects to the sectors list" do
      sector = Sector.create! valid_attributes
      delete sector_url(sector)
      expect(response).to redirect_to(sectors_url)
    end
  end
end
