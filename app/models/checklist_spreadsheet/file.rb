# frozen_string_literal: true

class ChecklistSpreadsheet::File
  def import_all(directory)
    Dir.glob("#{directory}/*.xls").sort.each do |path|
      import path
    end
  end

  def import(path, original_filename = nil)
    @file = File.open path
    @filename = original_filename || File.basename(@file.path)
    Rails.logger.debug { "Importing #{@filename}" }
    @workbook = create_workbook
    process_worksheets
  end

  private

  def create_workbook
    Spreadsheet.open @file
  end

  def process_worksheets
    checklist = ChecklistSpreadsheet::DataWorksheet.new(@workbook, @filename, 0).process
    ChecklistSpreadsheet::CommentsWorksheet.new(@workbook, @filename, 1).process(checklist) if @workbook.worksheets.size == 2
  end
end
