# frozen_string_literal: true

class ChecklistSpreadsheet::BaseData
  def initialize(checklist, rows)
    @checklist = checklist
    @sector = checklist.sector
    @survey = checklist.survey
    @rows = rows
  end

  def add_observation(row, indexes)
    taxon_index, count_index, notes_index = indexes
    taxon = row[taxon_index]
    count = row[count_index]

    return if taxon.nil? || count.nil?

    taxon = find_taxon taxon

    observation = @checklist.observations.build(sector: @sector, survey: @survey, taxon: taxon)

    if count.is_a? Integer
      observation.number = count
    else
      observation.count_week = true
    end

    observation.notes = row[notes_index] if notes_index
  end

  def find_taxon(name)
    taxon = Taxon.where(common_name: name).first

    raise "Taxon #{name} not found" if name && taxon.nil?

    taxon
  end
end
