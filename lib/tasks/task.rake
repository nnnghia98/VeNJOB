namespace :csv do
  desc "import data"
  task import: :environment do
    Import.new.import

    import = ActiveSupport::Logger.new("log/import.log")
    import.info "Cities, industries, companies, jobs imported succesfully at #{Time.current}"
  end
end

namespace :solr do
  desc "solr index data"
  task solr_index: :environment do
    SolrService.new.add_data

    index = ActiveSupport::Logger.new("log/solr_service.log")
    index.info "Solr index data succesfully at #{Time.current}"
  end

  desc "solr delete data"
  task solr_delete: :environment do
    SolrService.new.delete_data

    delete = ActiveSupport::Logger.new("log/solr_service.log")
    delete.info "Solr delete data succesfully at #{Time.current}"
  end
end
