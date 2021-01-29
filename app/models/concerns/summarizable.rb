module Summarizable
  extend ActiveSupport::Concern

  def aggregate_observations
    observations.reduce([]) do |aggregated, o|
      if existing = aggregated.find {|e| e.common_name == o.common_name}
        update_existing_observation(existing, o)
      else
        aggregated << o.dup
      end

      aggregated
    end
  end

  def species_total
    list = species_list.uniq { |o| o.taxon }

    total = list.count

    total -= list.count { |o| o.common_name =~ /Domestic/ }

    total -= list.count { |o| o.common_name =~ /^Bald Eagle/ } - 1
    total -= list.count { |o| o.common_name =~ /^Dark-eyed Junco/ } - 1
    total -= list.count { |o| o.common_name =~ /^Northern Flicker/ } - 1

    total
  end

  def count_week_total
    cw_list = count_week_list.uniq { |o| o.taxon }.map { |o| o.taxon }
    s_list = species_list.uniq { |o| o.taxon }.map { |o| o.taxon }

    cw_list.reject { |t| s_list.include? t }.count
  end

  def species_list
    list = observations.includes(:taxon).map { |o| o }.reject { |o|
      o.number.nil? ||
        o.common_name =~ /sp.$/ ||
        o.common_name == 'Western x Glaucous-winged Gull'
    }
  end

  def count_week_list
    list = observations.includes(:taxon).map { |o| o }.reject { |o|
      o.count_week.nil? ||
        o.common_name =~ /sp.$/ ||
        o.common_name == 'Western x Glaucous-winged Gull'
    }
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

  private

  def update_existing_observation(existing, current)
    if existing.number
      existing.number += current.number if current.number
    elsif current.number
      existing.number = current.number
      existing.count_week = false
    end
  end

  def method_missing(method_name, *args, &block)
    if name = method_name.to_s.match(/^(.+)_observers$/)
      checklist_observers name[1]
    elsif name = method_name.to_s.match(/^(.+)_total$/)
      checklist_total name[1]
    elsif name = method_name.to_s.match(/^(.+)_([^_]+)_ratio$/)
      ratio name[1], name[2]
    else
      super
    end
  end

  def checklist_observers(scope)
    scoped = checklists.send scope
    scoped.map { |c| c.observers unless !c.feeder_watch && c.max_parties == 0 }.flatten.compact.uniq
  end

  def checklist_total(property)
    checklists.field
      .reduce(0) { |total, checklist| total += checklist.send(property).to_f }
  end

  def ratio(method, base)
    association = self.send(base)
    self.send(method).fdiv(association.send(method))
  end
end
