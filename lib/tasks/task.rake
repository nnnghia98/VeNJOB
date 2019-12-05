# require "./app/services/import.rb"

namespace :task do
  desc "import data"
  task import: :environment do
    Import.new.import
  end
end
