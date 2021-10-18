class ChecklistImport
  class NoSectorError < StandardError; end
  class NoAreaError < StandardError; end

  def import_all(directory)
    Dir.glob("#{directory}/*.xls").sort.each do |path|
      import path
    end
  end

  def import(path)
    @file = File.open(path)
    puts "Importing #{@file.path}"
    create_worksheet
    create_checklist
    set_checklist_attributes
    @checklist.save!
  end

  private

  def create_worksheet
    @workbook = Spreadsheet.open @file
    @worksheet = @workbook.worksheet 0
  end

  def create_checklist
    @checklist = Checklist.new
  end

  def set_checklist_attributes
    set_survey
    set_sector
    set_area
    set_feeder_watch
    set_on_island
    set_parties
    set_time
    set_hours
    set_miles
    set_observers
    set_observations
  end

  def set_survey
    year = find_year
    survey = Survey.joins(:year).where('years.audubon_year = ?', year).first
    @checklist.survey = survey
  end

  def find_year
    re = Regexp.new /Vashon CBC ([0-9]+)/

    @worksheet.rows.each do |row|
      match = row[0].match re
      return match[1] if match
    end
  end

  def set_sector
    name = find_sector
    sector = Sector.where(name: name).first

    fail NoSectorError, "Sector #{name} not found - #{@file.path.split('/').last}" unless sector

    @checklist.sector = sector
  end

  def find_sector
    @worksheet.rows.each do |row|
      return row[3] if row[2] == "Sector"
    end
  end

  def set_area
    name = find_area

    area = @checklist.sector.areas.where('name = ?', name).first

    if area
      @checklist.area = area
    else
      fail NoAreaError, "Area #{name} not found - #{@file.path.split('/').last}" unless @file.path =~ /feeder/
    end
  end

  def find_area
    @worksheet.rows.each do |row|
      return row[3] if row[2] == "Area"
    end
  end

  def set_feeder_watch
    if @checklist.area
      @checklist.feeder_watch = false
    else
      @checklist.feeder_watch = true
      @checklist.location = find_area
    end
  end

  def set_on_island
    @checklist.on_island = find_on_island ? true : false
  end

  def find_on_island
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "On Island"
    end

    @checklist.sector.on_island
  end

  def set_parties
    unless @checklist.feeder_watch
      @checklist.max_parties = find_max_parties
      @checklist.min_parties = find_min_parties
    end
  end

  def find_max_parties
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "Max Parties"
    end

    1
  end

  def find_min_parties
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "Min Parties"
    end

    1
  end

  def set_time
    set_start_time
    set_end_time
    set_break_hours
  end

  def set_start_time
    time = find_start_time
    @checklist.start_time = time
  end

  def find_start_time
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "Start Time"
    end
  end

  def set_end_time
    time = find_end_time
    @checklist.end_time = time
  end

  def find_end_time
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "End Time"
    end
  end

  def set_break_hours
    @worksheet.rows.each do |row|
      @checklist.break_hours = row[1] if row[0] == "Break Hours"
    end
  end

  def set_hours
    set_hours_foot
    set_hours_car
    set_hours_boat
    set_hours_owling
    set_hours_total
  end

  def set_hours_foot
    hours = find_hours_foot
    @checklist.hours_foot = hours
  end

  def find_hours_foot
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "Hours on foot"
    end
  end

  def set_hours_car
    hours = find_hours_car
    @checklist.hours_car = hours
  end

  def find_hours_car
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "Hours by car"
    end
  end

  def set_hours_boat
    hours = find_hours_boat
    @checklist.hours_boat = hours
  end

  def find_hours_boat
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "Hours by boat"
    end
  end

  def set_hours_owling
    hours = find_hours_owling
    @checklist.hours_owling = hours
  end

  def find_hours_owling
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "Hours owling"
    end
  end

  def set_hours_total
    hours = find_hours_total
    @checklist.hours_total = hours
  end

  def find_hours_total
    @worksheet.rows.each do |row|
      return row[1] if row[0] == "TOTAL PARTY HOURS"
    end
  end

  def set_miles
    set_miles_foot
    set_miles_car
    set_miles_boat
    set_miles_owling
    set_miles_total
  end

  def set_miles_foot
    miles = find_miles_foot
    @checklist.miles_foot = miles
  end

  def find_miles_foot
    @worksheet.rows.each do |row|
      return row[3] if row[2] == "Miles on foot"
    end
  end

  def set_miles_car
    miles = find_miles_car
    @checklist.miles_car = miles
  end

  def find_miles_car
    @worksheet.rows.each do |row|
      return row[3] if row[2] == "Miles by car"
    end
  end

  def set_miles_boat
    miles = find_miles_boat
    @checklist.miles_boat = miles
  end

  def find_miles_boat
    @worksheet.rows.each do |row|
      return row[3] if row[2] == "Miles by boat"
    end
  end

  def set_miles_owling
    miles = find_miles_owling
    @checklist.miles_owling = miles
  end

  def find_miles_owling
    @worksheet.rows.each do |row|
      return row[3] if row[2] == "Miles owling"
    end
  end

  def set_miles_total
    miles = find_miles_total
    @checklist.miles_total = miles
  end

  def find_miles_total
    @worksheet.rows.each do |row|
      return row[3] if row[2] == "TOTAL PARTY MILES"
    end
  end

  def set_observers
    rows = @worksheet.rows.to_a[find_observers_start..find_page_2_start - 1]

    rows.each do |row|
      set_observer row
    end
  end

  def find_observers_start
    @worksheet.rows.index {|row| row[0] == "PARTY MEMBERS & EMAIL ADDRESSES"} + 1
  end

  def set_observer(row)
    return unless row[0]

    names = row[0].strip
    email = row[1].strip.downcase if row[1]

    first_name = names.split(' ')[0..-2].join(' ').strip
    last_name = names.split(' ')[-1].strip

    observer = Observer.find_by(first_name: first_name, last_name: last_name) ||
      Observer.new(first_name: first_name, last_name: last_name)

    set_observer_email observer, email if email

    @checklist.observers << observer
  end

  def set_observer_email(observer, email)
    if observer.persisted? && observer.email != email
      puts "Email address changed for #{observer.first_name} #{observer.last_name} -- old: #{observer.email}, new: #{email}"
    end

    observer.email = email

    observer.save!
  end

  def set_observations
    set_page_1_observations
    set_page_2_observations
  end

  def set_page_1_observations
    rows = @worksheet.rows.to_a[find_page_1_start..find_page_1_end]
    set_column_observations(rows, 0, 4)
    set_column_observations(rows, 2, 5)
  end

  def set_page_2_observations
    rows = @worksheet.rows.to_a[find_page_2_start..find_page_2_end]
    set_column_observations(rows, 0, 4)
    set_column_observations(rows, 2, 5)
  end

  def find_page_1_start
    @worksheet.rows.index {|row| row[0] == "Greater White-fronted Goose"}
  end

  def find_page_1_end
    @worksheet.rows.index {|row| row[0] == "Eared Grebe"}
  end

  def find_page_2_start
    @worksheet.rows.index {|row| row[0] == "Rock Pigeon"}
  end

  def find_page_2_end
    @worksheet.rows.index {|row| row[0] == "wren sp."}
  end

  def set_column_observations(rows, taxon_index, notes_index)
    rows.each do |row|
      taxon = find_taxon row[taxon_index]
      set_observation(taxon, row[taxon_index + 1], row[notes_index])
    end
  end

  def find_taxon(name)
    taxon = Taxon.where(common_name: name).first

    raise "Taxon #{name} not found" if name && taxon.nil?

    taxon
  end

  def set_observation(taxon, value, notes)
    return unless taxon && value

    observation = @checklist.observations.build(survey: @checklist.survey, taxon: taxon, notes: notes)

    if value.is_a? Fixnum
      observation.number = value
    else
      observation.count_week = true
    end
  end

end
