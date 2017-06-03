# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(100..117).each do |number|
  year = Year.create([{ audubon_year: number, vashon_year: number - 99 }])
end

sectors = YAML.load_file 'db/fixtures/sectors.yml'

sectors.each do |sector|
  Sector.create([{ name: sector['name'], code: sector['code'], on_island: sector['on_island'] }])
end

areas = YAML.load_file 'db/fixtures/areas.yml'

areas.each do |area|
  sector = Sector.where(code: area['code']).first
  Area.create([{ name: area['name'], on_island: area['on_island'], sector: sector }])
end

taxons = YAML.load_file 'db/fixtures/taxons.yml'

taxons.each_with_index do |taxon, index|
  Taxon.create([{ common_name: taxon['common_name'], cbc_name: taxon['cbc_name'], scientific_name: taxon['scientific_name'], taxonomic_order: index + 1 }])
end

DownloadedChecklistImport.new.import File.open('/home/ezra/Documents/CBC/Vashon Documents/WAVA-1997-2015.xls')

Survey.create([{ date: '2016-01-03', year: Year.all[-2] }])
Survey.create([{ date: '2017-01-02', year: Year.all.last }])

ChecklistImport.new.import_all '/home/ezra/Documents/CBC/Vashon\ 116\ -\ 01-03-2016/Data'

Taxon.where(common_name: 'Western Scrub-Jay').update_all(common_name: 'California Scrub-Jay')

ChecklistImport.new.import_all '/home/ezra/Documents/CBC/Vashon\ 117\ -\ 01-02-2017/Data'
