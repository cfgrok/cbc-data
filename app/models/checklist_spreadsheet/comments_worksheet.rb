class ChecklistSpreadsheet::CommentsWorksheet < ChecklistSpreadsheet::BaseWorksheet
  include TaxonMapping

  def process(checklist)
    @checklist = checklist

    info_end = @rows.index { |row| row.to_s.include? 'checklist comments' }

    @header = @rows.shift
    @rows = @rows.drop info_end
    @taxon_index = @header.index 'Species'
    @header.shift @taxon_index + 1

    find_comments
  end

  def find_comments
    @rows.each do |row|
      comments = row.drop @taxon_index + 1

      next if comments.compact.empty?

      map_taxon_in_row row, @taxon_index
      observation = @checklist.observations.by_common_name(row[@taxon_index]).first

      add_comments observation, comments

      observation.save
    end
  end

  def add_comments(observation, comments)
    notes = []

    comments.each_with_index do |cell, index|
      notes << strip_location_name(@header[index]) + ': ' + cell unless cell.nil?
    end

    observation.notes = notes.join "\n"
  end

  def strip_location_name(name)
    name = name.gsub /\s*\(?-?\d+\.\d+, -?\d+\.\d+\)?/, ''
    name = name.gsub /\s*US-\w{2}$/, ''
    name = name.gsub /,[\w\s]+,\s+US$/, ''
  end

end
