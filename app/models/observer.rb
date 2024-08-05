# frozen_string_literal: true

class Observer < ActiveRecord::Base
  scope :sorted, -> { order "last_name, first_name" }

  has_many :teams, dependent: :delete_all
  has_many :checklists, through: :teams

  def to_s
    "#{first_name} #{last_name}"
  end

  def email?
    email&.match(/@/)
  end
end
