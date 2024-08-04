# frozen_string_literal: true

json.extract! @observation, :id, :number, :taxon_id, :checklist_id, :count_week, :notes, :created_at, :updated_at
