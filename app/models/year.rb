# frozen_string_literal: true

class Year < ActiveRecord::Base
  has_one :survey, dependent: :destroy

  delegate :to_s, to: :audubon_year
end
