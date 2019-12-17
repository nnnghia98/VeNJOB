namespace :task do
  desc "import data"
  task import: :environment do
    Import.new.import
    JobsImport.new.import_job

    import = ActiveSupport::Logger.new("log/import.log")
    import.info "Cities, industries, companies, jobs imported: #{Time.current}"
  end
end
