# frozen_string_literal: true

class Observer < ActiveRecord::Base
  scope :sorted, -> { order "last_name, first_name" }

  has_and_belongs_to_many :checklists

  def to_s
    "#{first_name} #{last_name}"
  end

  def has_email?
    email&.match(/@/)
  end
end
