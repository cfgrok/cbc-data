class ChecklistImport
  def import(file)
    create_worksheet file
    create_checklist
    set_checklist_attributes
    @checklist.save!
  end

  private

  def create_worksheet(file)
    @workbook = Spreadsheet.open file.tempfile
    @worksheet = @workbook.worksheet 0
  end

  def create_checklist
    @checklist = Checklist.new
  end

  def set_checklist_attributes
    set_survey
    set_sector
    set_area
    set_time
    set_hours
    set_miles
    #set_observers
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
    @checklist.sector = sector
  end

  def find_sector
    @worksheet.rows.each do |row|
      return row[3] if row[2] == "Sector"
    end
  end

  def set_area
    name = find_area
    area = Area.where('name LIKE ?', "%#{name}%").first
    @checklist.area = area
  end

  def find_area
    @worksheet.rows.each do |row|
      return row[3] if row[2] == "Area"
    end
  end

  def set_time
    set_start_time
    set_end_time
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

  def set_observations
    set_page_1_observations
    set_page_2_observations
  end

  def set_page_1_observations
    rows = @worksheet.rows.to_a[find_page_1_start..find_page_1_end]
    set_column_observations(rows, 0)
    set_column_observations(rows, 2)
  end

  def set_page_2_observations
    rows = @worksheet.rows.to_a[find_page_2_start..find_page_2_end]
    set_column_observations(rows, 0)
    set_column_observations(rows, 2)
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

  def set_column_observations(rows, start)
    rows.each do |row|
      taxon = find_taxon row[start]
      set_observation(taxon, row[start + 1])
    end
  end

  def find_taxon(name)
    taxon = Taxon.where(common_name: name).first

    raise "Taxon #{name} not found" if !name.nil? && taxon.nil?

    taxon
  end

  def set_observation(taxon, value)
    return if taxon.nil? || value.nil?

    observation = @checklist.observations.build(taxon: taxon)

    if value.is_a? Fixnum
      observation.number = value
    else
      observation.count_week = true
    end
  end
end
