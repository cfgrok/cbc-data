# frozen_string_literal: true

json.array!(@observations) do |observation|
  json.extract! observation, :id, :number, :taxon_id, :checklist_id, :count_week, :notes
  json.url observation_url(observation, format: :json)
end
