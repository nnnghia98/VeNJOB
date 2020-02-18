require "rsolr"
require 'benchmark'

class SolrService
  def initialize
    @solr = RSolr.connect(
      url: Settings.solr.connection.server_url,
      read_timeout: Settings.solr.connection.read_timeout,
      open_timeout: Settings.solr.connection.open_timeout,
      retry_503: Settings.solr.connection.retry_503
    )
  end

  def add_data
    jobs = Job.includes(:cities, :industries, :company).all

    jobs_solr_index = jobs.map do |job|
      {
        id: job.id,
        title: job.title,
        industry: job.industries&.first&.name,
        description: job.description,
        short_des: job.short_des,
        salary: job.salary,
        company: job.company.name,
        city: job.cities&.first&.name,
      }
    end

    jobs_solr_index.each_slice(5000) do |job|
      @solr.add job
      rescue Exception
        job.each do |j|
          @solr.add j
          rescue
            solr_index_error = ActiveSupport::Logger.new("log/solr_errors.log")
            solr_index_error.info "This block got error! Cannot add job with id #{job.id}"
            next
        end
    end

    @solr.commit
  end

  def delete_data
    @solr.delete_by_query("*:*")
    @solr.commit
  end

  def search(params)
    response = @solr.get "select", params: {
      q: "*#{params}*",
      rows: Job.count
    }
    response["response"]
  end

  def query_by_city(city_name)
    city = "city: #{escape_str(city_name)}"
    response = @solr.get "select", params: {
      q: "*:*",
      fq: city,
      rows: Job.count
    }
    response["response"]
  end

  def query_by_industry(industry_name)
    industry = "industry: #{escape_str(industry_name)}"
    response = @solr.get "select", params: {
      q: "*:*",
      fq: industry,
      rows: Job.count
    }
    response["response"]
  end

  def escape_str(str)
    RSolr.solr_escape(str)
  end
end
