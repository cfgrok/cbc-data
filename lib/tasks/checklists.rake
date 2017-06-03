namespace :checklists do
  desc 'TODO'
  task import: :environment do
  end

  desc 'Import all checklist spreadsheets in a directory'
  task import_all: :environment do
    ChecklistImport.new.import_all ENV['directory']
  end

end
