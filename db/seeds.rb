# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(100..116).each do |number|
  year = Year.create([{ audubon_year: number, vashon_year: number - 99 }])
end

Survey.create([{ date: '2016-01-03', year: Year.all.last }])

sectors = YAML.load_file 'db/fixtures/sectors.yml'

sectors.each do |sector|
  Sector.create([{ name: sector['name'], code: sector['code'] }])
end

areas = YAML.load_file 'db/fixtures/areas.yml'

areas.each do |area|
  sector = Sector.where(code: area['code']).first
  Area.create([{ name: area['name'], sector: sector }])
end

taxons = YAML.load_file 'db/fixtures/taxons.yml'

taxons.each_with_index do |taxon, index|
  Taxon.create([{ common_name: taxon['common_name'], cbc_name: taxon['cbc_name'], scientific_name: taxon['scientific_name'], taxonomic_order: index + 1 }])
end
