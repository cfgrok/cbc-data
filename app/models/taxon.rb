class Taxon < ActiveRecord::Base
  has_many :observations

  def to_s
    common_name
  end
end
