# frozen_string_literal: true

require "logging"

Logging.color_scheme(
  "default",
  levels: {
    info: :green,
    warn: :yellow,
    error: :red,
    fatal: %i[white on_red]
  }
)

log_pattern = Logging.layouts.pattern(
  pattern: "[%d] %-5l %m\n",
  date_pattern: "%Y-%m-%d %H:%M:%S",
  color_scheme: "default"
)

Logging.appenders.stdout(
  "stdout",
  layout: log_pattern
)

log_file_appender = Logging.appenders.file(
  "log/#{Rails.env}.log",
  layout: log_pattern
)

rails_logger = Logging.logger["Rails"]
rails_logger.add_appenders log_file_appender

rails_logger.add_appenders "stdout" unless Rails.env.test?

Rails.logger = rails_logger
