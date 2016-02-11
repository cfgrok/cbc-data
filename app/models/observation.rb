class Observation < ActiveRecord::Base
  belongs_to :taxon
  belongs_to :checklist

  delegate :common_name, to: :taxon
end
