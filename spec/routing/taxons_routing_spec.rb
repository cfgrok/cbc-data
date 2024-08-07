# frozen_string_literal: true

require "rails_helper"

RSpec.describe TaxonsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/taxons").to route_to("taxons#index")
    end

    it "routes to #new" do
      expect(get: "/taxons/new").to route_to("taxons#new")
    end

    it "routes to #show" do
      expect(get: "/taxons/1").to route_to("taxons#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/taxons/1/edit").to route_to("taxons#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/taxons").to route_to("taxons#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/taxons/1").to route_to("taxons#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/taxons/1").to route_to("taxons#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/taxons/1").to route_to("taxons#destroy", id: "1")
    end
  end
end
