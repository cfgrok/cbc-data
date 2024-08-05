# frozen_string_literal: true

class RouteRecognizer
  attr_reader :paths

  # To use this inside your app, call:
  # `RouteRecognizer.new.initial_path_segments`
  # This returns an array, e.g.: ['assets','blog','team','faq','users']

  INITIAL_SEGMENT_REGEX = %r{^/([^/(:]+)}.freeze

  def initialize
    routes = Rails.application.routes.routes
    @paths = routes.collect { |r| r.path.spec.to_s }
  end

  def initial_path_segments
    @initial_path_segments ||= paths.collect { |path| match_initial_path_segment(path) }.compact.uniq
  end

  def match_initial_path_segment(path)
    return unless (match = INITIAL_SEGMENT_REGEX.match(path))

    match[1]
  end
end
