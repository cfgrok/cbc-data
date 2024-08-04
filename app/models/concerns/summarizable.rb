# frozen_string_literal: true

module Summarizable
  extend ActiveSupport::Concern

  def aggregate_observations
    @aggregate_observations ||= observations.each_with_object([]) do |o, aggregated|
      if existing = aggregated.find { |e| e.common_name == o.common_name }
        update_existing_observation(existing, o)
      else
        aggregated << o.dup
      end
    end
  end

  def species_total
    list = species_list.map(&:common_name).uniq

    remove_spuhs list
    remove_slashes list
    remove_duplicates list

    list.size
  end

  def count_week_total
    s_list = species_list.map(&:common_name).uniq
    cw_list = count_week_list.map(&:common_name).uniq

    remove_spuhs cw_list
    remove_slashes cw_list
    remove_duplicates cw_list, s_list

    cw_list.reject { |common_name| s_list.include? common_name }.size
  end

  def species_list
    observations.reject { |o| o.number.nil? || o.number.zero? }
  end

  def count_week_list
    observations.reject { |o| o.count_week.nil? }
  end

  def remove_spuhs(list)
    list.reject! { |common_name| common_name =~ /(Domestic|sp.$| x )/ }
  end

  def remove_slashes(list)
    slashes = list.grep(%r{/})
    slashes.each do |common_name|
      names = common_name.split(%r{[ /]})
      group = names.reverse!.shift
      names.each do |name|
        list.delete common_name if list.index { |cn| cn == "#{name} #{group}" }
      end
    end
  end

  def remove_duplicates(list, alternate_list = [])
    patterns = ["Bald Eagle", "Northern Flicker", "Dark-eyed Junco", "Yellow-rumped Warbler"]

    patterns.each do |pattern|
      exclude_duplicate_taxon pattern, list, alternate_list
    end
  end

  def individual_total
    observations.reduce(0) { |count, o| count += o.number.to_i }
  end

  def first_start_time
    checklists.field.has_start_time
      .map(&:start_time)
      .reduce { |first, time| first && first < time ? first : time }
  end

  def last_end_time
    checklists.field.has_end_time
      .map(&:end_time)
      .reduce { |last, time| last && last > time ? last : time }
  end

  def feeder_hours_total
    checklists.feeder
      .reduce(0) { |total, checklist| total += checklist.hours_total.to_f }
  end

  def participant_total
    checklists
      .reduce([]) { |observers, checklist| observers << checklist.observers }
      .flatten.uniq.size
  end

  def participant_hours_total
    checklists
      .reduce(0) do |total, checklist|
        hours = if checklist.min_parties && checklist.min_parties > 1
          (checklist.hours_total.to_f / checklist.min_parties * 4).round / 4.0
        else
          checklist.hours_total.to_f
        end
        total += hours * checklist.observers.size
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

  def exclude_duplicate_taxon(pattern, list, alternate_list)
    regexp = /^#{pattern}/
    duplicates = list.grep(regexp).drop 1
    list.reject! { |common_name| duplicates.include? common_name } unless duplicates.empty?

    if !alternate_list.empty? && !alternate_list.grep(regexp).empty?
      list.reject! { |common_name| common_name =~ regexp }
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
    scoped.map(&:observers).flatten.compact.uniq.sort_by { |o| [o.last_name, o.first_name] }
  end

  def checklist_total(property)
    checklists.field
      .reduce(0) { |total, checklist| total += checklist.send(property).to_f }
  end

  def ratio(method, base)
    association = send(base)
    send(method).fdiv(association.send(method))
  end
end
