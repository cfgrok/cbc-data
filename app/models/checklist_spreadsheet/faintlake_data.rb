# frozen_string_literal: true

class ChecklistSpreadsheet::FaintlakeData < ChecklistSpreadsheet::BaseData
  include TaxonMapping

  def process
    taxon_index = @rows.first.index "Species"
    count_index = @rows.first.index "Sum"

    remove_info_rows
    replace_formulas count_index

    process_data_rows taxon_index, count_index
  end

  def remove_info_rows
    last_header = @rows.index { |row| row.map(&:to_s).include? "checklist comments" }
    @rows = @rows.slice last_header + 1, @rows.size - last_header - 2
  end

  def replace_formulas(count_index)
    @rows.each do |row|
      row[count_index] = row[count_index].value.to_i if row[count_index].respond_to? :value
    end
  end

  def process_data_rows(taxon_index, count_index)
    @rows.each do |row|
      map_taxon_in_row row, taxon_index

      notes_index = row.size > count_index + 1 ? row.size - 1 : nil

      add_observation row, [taxon_index, count_index, notes_index]
    end
  end
end
