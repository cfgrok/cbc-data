# frozen_string_literal: true

class Taxon < ActiveRecord::Base
  has_many :observations, dependent: :delete_all

  def to_s
    common_name
  end
end
