# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :list_paths, only: [:index]

  # GET /home
  # GET /home.json
  def index; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def list_paths
    @paths = RouteRecognizer.new.initial_path_segments.reject do |path|
      %w[assets rails].include? path
    end
  end
end
