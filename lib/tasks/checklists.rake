namespace :checklists do

  desc 'Import a checklist spreadsheet'
  task import: :environment do
    ChecklistImport.new.import ENV['file']
  end

  desc 'Import all checklist spreadsheets in a directory'
  task import_all: :environment do
    ChecklistImport.new.import_all ENV['directory']
  end

end
