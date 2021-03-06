require "rsolr"

class SolrService
  def initialize(params = {search: "*:*"})
    @solr = RSolr.connect(
      url: Settings.solr.connection.server_url,
      read_timeout: Settings.solr.connection.read_timeout,
      open_timeout: Settings.solr.connection.open_timeout,
      retry_503: Settings.solr.connection.retry_503
    )

    @params = params
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

    jobs_solr_index.each_slice(5000) do |jobs|
      @solr.add jobs
      rescue Exception
        jobs.each do |job|
          @solr.add job
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

  def query_all
    q = "*#{@params[:search]}*"
    fq = ""

    send_request(q, fq)
  end

  def query_by_city
    city = City.find_by(id: @params[:city_id])
    return { "numFound": 0, "docs": [] } unless city

    city_name = city.name


    q = "*:*"
    fq = "city: #{escape_str(city_name)}"

    send_request(q, fq)
  end

  def query_by_industry
    industry = Industry.find_by(id: @params[:industry_id])
    return { "numFound": 0, "docs": [] } unless industry

    industry_name = industry.name

    q = "*:*"
    fq = "industry: #{escape_str(industry_name)}"

    send_request(q, fq)
  end

  def send_request(q, fq)
    response = @solr.get "select", params: {
      q: q,
      fq: fq,
      rows: Job.count
    }
    response["response"]
  end

  def escape_str(str)
    RSolr.solr_escape(str)
  end
end
