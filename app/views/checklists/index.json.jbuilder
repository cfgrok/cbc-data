json.array!(@checklists) do |checklist|
  json.extract! checklist, :id, :survey_id, :sector_id, :area_id, :feeder_watch, :location, :start_time, :end_time, :hours_foot, :hours_car, :hours_boat, :hours_owling, :hours_total, :miles_foot, :miles_car, :miles_boat, :miles_owling, :miles_total
  json.url checklist_url(checklist, format: :json)
end
