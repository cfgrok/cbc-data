# frozen_string_literal: true

json.array!(@years) do |year|
  json.extract! year, :id, :audubon_year, :vashon_year
  json.url year_url(year, format: :json)
end
