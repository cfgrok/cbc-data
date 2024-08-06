# frozen_string_literal: true

class Year < ActiveRecord::Base
  has_one :survey, dependent: :destroy

  validates :audubon_year, :vashon_year, numericality: { only_integer: true, greater_than: 0 }

  delegate :to_s, to: :audubon_year
end
