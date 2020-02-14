require "rsolr"

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
    @solr.add jobs_solr_index
    @solr.commit
  end

  def delete_data
    @solr.delete_by_query("*:*")
    @solr.commit
  end

  def search(params)
    # city = @city.present? ? "city:\"#{escape_str(@city.name)}\"" : ""
    # industry = @industry.present? ? "industry:\"#{escape_str(@industry.name)}\"" : ""
    response = @solr.get "select", params: {
      q: "*#{params}*",
      # fq: [industry, city],
      rows: Job.count
    }
    response["response"]["docs"]
  end

  def escape_str(str)
    RSolr.solr_escape(str)
  end
end
