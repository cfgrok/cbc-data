# frozen_string_literal: true

json.array!(@areas) do |area|
  json.extract! area, :id, :name, :sector_id
  json.url area_url(area, format: :json)
end
