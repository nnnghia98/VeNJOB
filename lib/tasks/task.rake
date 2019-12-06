namespace :task do
  desc "import data"
  task import: :environment do
    Import.new.import
    JobsImport.new.import_job
  end
end
