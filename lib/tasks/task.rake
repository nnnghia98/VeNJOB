namespace :task do
  desc "import data"
  task import: :environment do
    Import.new.import

    import = ActiveSupport::Logger.new("log/import.log")
    import.info "Cities, industries, companies, jobs imported succesful at #{Time.current}"
  end
end
