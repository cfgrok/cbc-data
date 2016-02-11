module Summarizable
  extend ActiveSupport::Concern

  def species_total
    list = observations.includes(:taxon).map { |o| o }.uniq { |o| o.taxon }
      .reject { |o| o.common_name =~ /sp.$/ || o.common_name == 'Western x Glaucous-winged Gull' }

    total = list.count

    total -= 1 if list.count { |o| o.common_name =~ /^Bald Eagle/ } > 1
    total -= 1 if list.count { |o| o.common_name =~ /^Dark-eyed Junco/ } > 1

    total
  end

  def individual_total
    observations.reduce(0) { |count, o| count += o.number.to_i }
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

  def feeder_hours_total
    checklists.feeder
      .reduce(0) { |total, checklist| total += checklist.hours_total.to_f }
  end

  def method_missing(method_name, *args, &block)
    if name = method_name.to_s.match(/^(.+)_observer_total$/)
      observer_total name[1]
    elsif name = method_name.to_s.match(/^(.+)_total$/)
      checklist_total name[1]
    end
  end

  def observer_total(scope)
    scoped = checklists.send scope
    scoped.map { |c| c.observers }.flatten.uniq.length
  end

  def checklist_total(property)
    checklists.field
      .reduce(0) { |total, checklist| total += checklist.send(property).to_f }
  end
end
