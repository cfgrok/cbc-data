# frozen_string_literal: true

json.extract! @checklist, :id, :survey_id, :sector_id, :area_id, :max_parties, :min_parties, :feeder_watch, :location, :start_time, :end_time, :break_hours, :hours_foot, :hours_car, :hours_boat, :hours_owling, :hours_total, :miles_foot, :miles_car, :miles_boat, :miles_owling, :miles_total, :created_at, :updated_at
