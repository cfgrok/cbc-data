# frozen_string_literal: true

class Team < ActiveRecord::Base
  self.table_name = "checklists_observers"

  belongs_to :checklist
  belongs_to :observer
end
