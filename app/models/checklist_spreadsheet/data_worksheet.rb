# frozen_string_literal: true

class ChecklistSpreadsheet::DataWorksheet < ChecklistSpreadsheet::BaseWorksheet
  class NoSectorError < StandardError; end
  class NoAreaError < StandardError; end

  def initialize(*args)
    super
    @attribute_rows = []
    @checklist = Checklist.new
  end

  def process
    set_checklist_attributes
    set_observers

    remove_empty_rows
    remove_custom_rows

    set_observations

    @checklist.save!
    @checklist
  end

  def set_checklist_attributes
    set_survey
    set_sector
    set_area
    set_feeder_watch
    set_parties
    set_time
    set_hours
    set_miles

    remove_attribute_rows
  end

  def set_survey
    year = find_year
    survey = Survey.joins(:year).where("years.#{get_cbc_config(:checklist_year_type)} = ?", year).first

    @checklist.survey = survey
  end

  def find_year
    re = Regexp.new(/#{Regexp.quote(get_cbc_config(:count_name))} ([0-9]+)/)

    @rows.each_with_index do |row, index|
      match = row[0].match re

      if match
        @attribute_rows << index
        return match[1]
      end
    end
  end

  def set_sector
    name = find_attribute "Sector"
    sector = Sector.where(name: name).first

    raise NoSectorError, "Sector #{name} not found" unless sector

    @checklist.sector = sector
  end

  def set_area
    name = find_attribute "Area"
    area = Area.where(name: name, sector: @checklist.sector).first

    raise NoAreaError, "Area #{name} not found" unless area || @filename.include?("feeder")

    @checklist.area = area
  end

  def set_feeder_watch
    if @checklist.area
      @checklist.feeder_watch = false
    else
      @checklist.feeder_watch = true
      @checklist.location = find_attribute "Area"
    end
  end

  def set_parties
    unless @checklist.feeder_watch
      @checklist.max_parties = find_attribute("Max Parties") || 1
      @checklist.min_parties = find_attribute("Min Parties") || 1
    end
  end

  def set_time
    set_start_time
    set_end_time
    set_break_hours
  end

  def set_start_time
    @checklist.start_time = find_attribute "Start Time"
  end

  def set_end_time
    @checklist.end_time = find_attribute "End Time"
  end

  def set_break_hours
    @checklist.break_hours = find_attribute "Break Hours"
  end

  def set_hours
    set_hours_foot
    set_hours_car
    set_hours_boat
    set_hours_owling
    set_hours_total
  end

  def set_hours_foot
    @checklist.hours_foot = find_attribute "Hours on foot"
  end

  def set_hours_car
    @checklist.hours_car = find_attribute "Hours by car"
  end

  def set_hours_boat
    @checklist.hours_boat = find_attribute "Hours by boat"
  end

  def set_hours_owling
    @checklist.hours_owling = find_attribute "Hours owling"
  end

  def set_hours_total
    @checklist.hours_total = find_attribute "TOTAL PARTY HOURS"
  end

  def set_miles
    set_miles_foot
    set_miles_car
    set_miles_boat
    set_miles_owling
    set_miles_total
  end

  def set_miles_foot
    @checklist.miles_foot = find_attribute "Miles on foot"
  end

  def set_miles_car
    @checklist.miles_car = find_attribute "Miles by car"
  end

  def set_miles_boat
    @checklist.miles_boat = find_attribute "Miles by boat"
  end

  def set_miles_owling
    @checklist.miles_owling = find_attribute "Miles owling"
  end

  def set_miles_total
    @checklist.miles_total = find_attribute "TOTAL PARTY MILES"
  end

  def set_observers
    start = find_observers_start
    observer_rows = @rows[start, @rows.size - start].take_while { |row| !row.compact.empty? }

    observer_rows.each do |row|
      set_observer row
    end

    remove_observer_rows start, observer_rows.size
  end

  def find_observers_start
    @rows.index { |row| row.include? "PARTY MEMBERS & EMAIL ADDRESSES" } + 1
  end

  def set_observer(row)
    return unless row[0]

    names = row[0].strip
    email = row[1].strip.downcase if row[1]

    first_name = names.split[0..-2].join(" ").strip
    last_name = names.split[-1].strip.tr("_", " ")

    observer = Observer.find_by(first_name: first_name, last_name: last_name) ||
      (email && Observer.find_by(last_name: last_name, email: email)) ||
      (email && Observer.find_by(first_name: first_name, email: email)) ||
      Observer.new

    set_observer_first_name observer, first_name
    set_observer_last_name observer, last_name
    set_observer_email observer, email if email

    observer.save!

    @checklist.observers << observer
  end

  def set_observer_first_name(observer, first_name)
    if observer.persisted? && observer.first_name != first_name
      Rails.logger.debug { "First name changed for #{observer.first_name} #{observer.last_name} -- new: #{first_name}" }
    end

    observer.first_name = first_name
  end

  def set_observer_last_name(observer, last_name)
    if observer.persisted? && observer.last_name != last_name
      Rails.logger.debug { "Last name changed for #{observer.first_name} #{observer.last_name} -- new: #{last_name}" }
    end

    observer.last_name = last_name
  end

  def set_observer_email(observer, email)
    if observer.persisted? && observer.email != email
      Rails.logger.debug { "Email address changed for #{observer.first_name} #{observer.last_name} -- old: #{observer.email}, new: #{email}" }
    end

    observer.email = email
  end

  def set_observations
    if (found = row_search("Species")) && found[0].include?("Sum")
      ChecklistSpreadsheet::FaintlakeData.new(@checklist, @rows).process
    else
      ChecklistSpreadsheet::CustomData.new(@checklist, @rows).process
    end
  end

  private

  def get_cbc_config(key)
    Rails.configuration.cbc[key]
  end

  def find_attribute(attribute)
    if found = row_search(attribute)
      @attribute_rows << found[1]
      extract_cell_value found[0][found[2] + 1]
    end
  end

  def extract_cell_value(cell_value)
    return cell_value.value if cell_value.is_a? Spreadsheet::Formula

    cell_value
  end

  def remove_attribute_rows
    @rows.delete_if.with_index { |_, index| @attribute_rows.include? index }
  end

  def remove_observer_rows(start, length)
    @rows.delete_if.with_index { |_, index| index >= start - 1 && index < start + length }
  end

  def remove_empty_rows
    @rows.delete_if { |row| row.compact.empty? }
  end

  def remove_custom_rows
    custom_values = get_cbc_config :custom_rows

    custom_values.each do |value|
      re = Regexp.new value.downcase

      @rows.delete_if do |row|
        row_data = row.map { |cell| cell.to_s.downcase }

        row_data.index { |cell| cell =~ re }
      end
    end
  end
end
