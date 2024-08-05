# frozen_string_literal: true

class Area < ActiveRecord::Base
  belongs_to :sector
  has_many :checklists, dependent: :nullify

  def to_s
    "#{sector.code} - #{name}"
  end
end
