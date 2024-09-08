# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :list_paths, only: [:index]

  # GET /home
  # GET /home.json
  def index
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def list_paths
    @paths = RouteRecognizer.new.initial_path_segments.select do |path|
      exclusions.exclude? path
    end
  end

  def exclusions
    %w[assets rails]
  end
end
