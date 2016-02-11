class Row
  attr_accessor :taxon, :observation

  def initialize(taxon, observation)
    self.taxon = taxon
    self.observation = observation
  end

  def common_name
    @taxon.common_name
  end

  def taxon_id
    @taxon.id
  end

  def id
    @observation && @observation.id
  end

  def number
    @observation && @observation.number
  end

  def count_week
    @observation && @observation.count_week
  end

  def persisted?
    false
  end
end
