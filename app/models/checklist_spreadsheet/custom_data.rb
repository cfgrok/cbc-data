# frozen_string_literal: true

class ChecklistSpreadsheet::CustomData < ChecklistSpreadsheet::BaseData
  def initialize(*args)
    super
    @custom_row_format = Rails.configuration.cbc[:custom_row_format]
  end

  def process
    @custom_row_format.each do |indexes|
      @rows.each do |row|
        add_observation row, indexes
      end
    end
  end
end
