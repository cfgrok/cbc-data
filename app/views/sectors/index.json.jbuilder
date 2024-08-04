# frozen_string_literal: true

json.array!(@sectors) do |sector|
  json.extract! sector, :id, :name, :code
  json.url sector_url(sector, format: :json)
end
