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

  def first_start_time
    checklists.field.has_start_time
      .map { |checklist| checklist.start_time }
      .reduce { |first, time| first && first < time ? first : time }
  end

  def last_end_time
    checklists.field.has_end_time
      .map { |checklist| checklist.end_time }
      .reduce { |last, time| last && last > time ? last : time }
  end

  def field_observer_total
    checklists.field
      .map { |c| c.observers }
      .flatten
      .uniq
      .length
  end

  def parties_total
    checklists.field
      .reduce(0) {|total, c| total + c.parties}
  end

  def feeder_watch_observer_total
    checklists.feeder
      .map { |c| c.observers }
      .flatten
      .uniq
      .length
  end
end
