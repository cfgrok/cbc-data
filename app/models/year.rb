# frozen_string_literal: true

class Year < ActiveRecord::Base
  has_one :survey

  delegate :to_s, to: :audubon_year
end
