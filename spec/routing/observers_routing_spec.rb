# frozen_string_literal: true

require "rails_helper"

RSpec.describe ObserversController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/observers").to route_to("observers#index")
    end

    it "routes to #new" do
      expect(get: "/observers/new").to route_to("observers#new")
    end

    it "routes to #show" do
      expect(get: "/observers/1").to route_to("observers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/observers/1/edit").to route_to("observers#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/observers").to route_to("observers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/observers/1").to route_to("observers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/observers/1").to route_to("observers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/observers/1").to route_to("observers#destroy", id: "1")
    end
  end
end
