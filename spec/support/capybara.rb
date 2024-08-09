# frozen_string_literal: true

require "capybara/rails"

Capybara.default_driver = :selenium_headless
Capybara.server = :webrick
