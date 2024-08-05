# frozen_string_literal: true

class ChecklistSpreadsheet::BaseWorksheet
  def initialize(workbook, filename, index)
    @workbook = workbook
    @filename = filename
    @worksheet = @workbook.worksheet index
    @rows = trim_worksheet
  end

  private

  def trim_worksheet
    rows = trim_rows
    trim_columns rows
  end

  def trim_rows
    rows = @worksheet.rows.to_a
    last_row = rows.rindex { |row| !row.to_a.compact.empty? }
    rows.take last_row + 1
  end

  def trim_columns(rows)
    width = rows.reduce(0) do |index, row|
      last = (row.rindex { |cell| cell } || 0) + 1
      last > index ? last : index
    end

    rows.map { |row| row.to_a.take width }
  end

  def row_search(content)
    @rows.each_with_index do |row, row_index|
      next if row.compact.empty?

      column_index = row.index { |r| r.to_s.casecmp(content).zero? }

      return [row, row_index, column_index] if column_index
    end

    nil
  end
end
