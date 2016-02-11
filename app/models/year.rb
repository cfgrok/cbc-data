class Year < ActiveRecord::Base
  has_one :survey

  def to_s
    audubon_year.to_s
  end
end
