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

    solr_index_logger = ActiveSupport::Logger.new("log/solr_service.log")
    solr_index_logger.info "Solr index data succesfully at #{Time.current}"
  end

  desc "solr delete data"
  task solr_delete: :environment do
    SolrService.new.delete_data

    solr_delete_logger = ActiveSupport::Logger.new("log/solr_service.log")
    solr_delete_logger.info "Solr delete all data succesfully at #{Time.current}"
  end
end

namespace :crawl do
  desc "crawl data from careerbuilder.vn"
  task crawl_data: :environment do
    CrawlData.new.crawl_web

    # crawl = ActiveSupport::Logger.new("log/crawl_data.log")
    # crawl.info "Crawl data from careerbuilder.vn succesfully at #{Time.current}"
  end
end
