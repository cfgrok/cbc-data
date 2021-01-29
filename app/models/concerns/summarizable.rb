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

    remove_spuhs list
    remove_slashes list

    list.count
  end

  def count_week_total
    s_list = species_list.uniq { |o| o.taxon }.map { |o| o.common_name }
    cw_list = count_week_list.uniq { |o| o.taxon }

    remove_spuhs cw_list
    remove_slashes cw_list

    cw_list.reject { |o| s_list.include? o.common_name }.count
  end

  def species_list
    observations.reject { |o| o.number.nil? || o.number == 0 }
  end

  def count_week_list
    observations.reject { |o| o.count_week.nil? }
  end

  def remove_spuhs(list)
    list.reject! { |o| o.common_name =~ /(Domestic|sp.$| x )/ }

    exclude_duplicate_taxon list, /^Bald Eagle/
    exclude_duplicate_taxon list, /^Northern Flicker/
    exclude_duplicate_taxon list, /^Dark-eyed Junco/
  end

  def remove_slashes(list)
    slashes = list.select { |o| o.common_name =~ /\// }
    slashes.each do |observation|
      names = observation.common_name.split /[ \/]/
      group = names.reverse!.shift
      names.each do |name|
        list.delete observation if list.index { |o| o.common_name == name + ' ' + group }
      end
    end
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

  def participant_total
    checklists
      .reduce([]) { |observers, checklist| observers << checklist.observers}
      .flatten.uniq.count
  end

  def participant_hours_total
    checklists
      .reduce(0) do |total, checklist|
        if checklist.min_parties && checklist.min_parties > 1
          hours = checklist.hours_total.to_f / checklist.min_parties
        else
          hours = checklist.hours_total.to_f
        end
        total += hours * checklist.observers.count
      end
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

  def exclude_duplicate_taxon(list, regexp)
    duplicates = list.select { |o| o.common_name =~ regexp }.drop 1
    list.reject! { |o| duplicates.include? o }
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
    scoped.map { |c| c.observers }.flatten.compact.uniq.sort_by { |o| [o.last_name, o.first_name] }
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
