module Summarizable
  extend ActiveSupport::Concern

  def species_total
    list = observations.includes(:taxon).map { |o| o }.uniq { |o| o.taxon }

    total = list.reduce(0) do |count, o|
      count += 1 unless o.common_name.match(/sp.$/)
      count
    end

    total -= 1 if list.find { |o| o.common_name == 'Western x Glaucous-winged Gull' }
    total -= 1 if list.count { |o| o.common_name =~ /^Bald Eagle/ } == 2
    total -= 1 if list.count { |o| o.common_name =~ /^Dark-eyed Junco/ } == 2

    total
  end

  def individual_total
    observations.reduce(0) do |count, o|
      count += o.number unless o.number.nil?
      count
    end
  end

  def observer_total
    observations.map { |o| o.checklist }
      .uniq
      .map { |o| o.observers }
      .flatten
      .uniq
      .length
  end
end
