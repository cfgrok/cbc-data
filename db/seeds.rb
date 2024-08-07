# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(100..124).each do |number|
  Year.create([{ audubon_year: number, vashon_year: number - 99 }])
end

sectors = YAML.load_file "db/fixtures/sectors.yml"

sectors.each do |sector|
  Sector.create([{ name: sector["name"], code: sector["code"], on_island: sector["on_island"] }])
end

areas = YAML.load_file "db/fixtures/areas.yml"

areas.each do |area|
  sector = Sector.where(code: area["code"]).first
  Area.create([{ name: area["name"], on_island: area["on_island"], sector: sector }])
end

taxons = YAML.load_file "db/fixtures/taxons.yml"

taxons.each_with_index do |taxon, index|
  Taxon.create([{ common_name: taxon["common_name"], cbc_name: taxon["cbc_name"], scientific_name: taxon["scientific_name"], taxonomic_order: index + 1 }])
end

DownloadedChecklistImport.new.import "/home/ezra/Sync/CBC/Vashon Documents/WAVA-2000-2015.xls"

Survey.create([{ date: "2016-01-03", year: Year.all[-9] }])
Survey.create([{ date: "2017-01-02", year: Year.all[-8] }])
Survey.create([{ date: "2017-12-31", year: Year.all[-7] }])
Survey.create([{ date: "2018-12-30", year: Year.all[-6] }])
Survey.create([{ date: "2020-01-05", year: Year.all[-5] }])
Survey.create([{ date: "2021-01-03", year: Year.all[-4] }])
Survey.create([{ date: "2022-01-03", year: Year.all[-3] }])
Survey.create([{ date: "2023-01-02", year: Year.all[-2] }])
Survey.create([{ date: "2023-12-31", year: Year.all[-1] }])

ChecklistSpreadsheet::File.new.import_all "/home/ezra/Sync/CBC/Vashon 116 - 01-03-2016/Data"

# rubocop:todo Rails/SkipsModelValidations
Taxon.where(common_name: "Western Scrub-Jay").update_all(common_name: "California Scrub-Jay")
# rubocop:enable Rails/SkipsModelValidations

ChecklistSpreadsheet::File.new.import_all "/home/ezra/Sync/CBC/Vashon 117 - 01-02-2017/Data"

# rubocop:todo Rails/SkipsModelValidations
Taxon.where(common_name: "Thayer's Gull").update_all(common_name: "Iceland Gull (Thayer's)")
# rubocop:enable Rails/SkipsModelValidations

ChecklistSpreadsheet::File.new.import_all "/home/ezra/Sync/CBC/Vashon 118 - 12-31-2017/Data"

ChecklistSpreadsheet::File.new.import_all "/home/ezra/Sync/CBC/Vashon 119 - 12-30-2018/Data"

ChecklistSpreadsheet::File.new.import_all "/home/ezra/Sync/CBC/Vashon 120 - 01-05-2020/Data"

ChecklistSpreadsheet::File.new.import_all "/home/ezra/Sync/CBC/Vashon 121 - 01-03-2021/Data"

# rubocop:todo Rails/SkipsModelValidations
Taxon.where(common_name: "Mew Gull").update_all(common_name: "Short-billed Gull")
# rubocop:enable Rails/SkipsModelValidations

ChecklistSpreadsheet::File.new.import_all "/home/ezra/Sync/CBC/Vashon 122 - 01-03-2022/Data"

# rubocop:todo Rails/SkipsModelValidations
Taxon.where(common_name: "Bald Eagle adult").update_all(common_name: "Bald Eagle")
# rubocop:enable Rails/SkipsModelValidations

ChecklistSpreadsheet::File.new.import_all "/home/ezra/Sync/CBC/Vashon 123 - 01-02-2023/Data"

ChecklistSpreadsheet::File.new.import_all "/home/ezra/Sync/CBC/Vashon 124 - 12-31-2023/Data"
