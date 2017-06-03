class DownloadedChecklistImport < ChecklistImport
  def import(file)
    puts "Importing #{file.path}"
    @file = file
    create_worksheet file
    import_checklists
  end

  private

  def import_checklists
    find_header_row
    find_end_index
    find_columns
    find_taxon_rows
    import_years
  end

  def find_header_row
    @header_row = @worksheet.rows[find_header_index]
  end

  def find_header_index
    re = Regexp.new /^Checklist$/

    @worksheet.rows.each_with_index do |row, index|
      return @header_index = index + 2 if row[2] && row[2].match(re)
    end
  end

  def find_end_index
    re = Regexp.new /^Compiler\(s\)$/

    @worksheet.rows.each_with_index do |row, index|
      return @end_index = index - 3 if row[1] && row[1].match(re)
    end
  end

  def find_columns
    @years = []

    re = Regexp.new /^\d{4} \[(\d+)\]\nCount Date: (\d+)\/(\d+)\/(\d+)\n/

    @header_row.each_with_index do |cell, index|
      @taxon_index = index if cell == 'Species'

      match = cell && cell.match(re)
      if match
        @years << [index, match[1], "#{match[4]}-#{match[2]}-#{match[3]}"]
      end
    end
  end

  def find_taxon_rows
    @taxon_rows = @worksheet.rows.slice(@header_index+1..@end_index)
                      .each_slice(3).map(&:first)
  end

  def import_years
    @years.each do |year|
      @year = year

      create_checklist
      set_checklist_attributes year
      @checklist.save!
    end
  end

  def set_checklist_attributes(year)
    create_survey
    set_survey
    set_feeder_watch
    set_observations
  end

  def create_survey
    year = Year.find_by(audubon_year: find_year)
    Survey.find_or_create_by(year: year, date: find_date)
  end

  def find_year
    @year[1]
  end

  def find_date
    @year[2]
  end

  def set_feeder_watch
    @checklist.feeder_watch = false
  end

  def set_observations
    @taxon_rows.each do |row|
      value = row[@year.first]

      unless value.nil?
        taxon = find_taxon row
        value = value.to_i if value =~ /^\d+$/
        set_observation(taxon, value, nil)
      end
    end
  end

  def find_taxon(row)
    taxon = Taxon.where(cbc_name: row[@taxon_index].split("\n").first).first

    raise "Taxon #{name} not found" if taxon.nil?

    taxon
  end
end
