require "rsolr"

class SolrService
  def initialize
    @solr = RSolr.connect(
      :url => Settings.solr.connection.server_url,
      :read_timeout => Settings.solr.connection.read_timeout,
      :open_timeout => Settings.solr.connection.open_timeout,
      :retry_503 => Settings.solr.connection.retry_503
    )
  end

  def add_data
    jobs = Job.includes(:cities, :industries, :company).all
    jobs_solr_index = jobs.map do |job|
      {
        id: job.id,
        title: job.title,
        category: job.category,
        description: job.description,
        short_des: job.short_des,
        salary: job.salary,
        company: job.company.name,
        city: job.cities&.first&.name,
        industry: job.industries&.first&.name
      }
    end
    @solr.add jobs_solr_index
    @solr.commit
  end

  def delete_data
    jobs = Job.includes(:cities, :industries, :company).all
    jobs_solr_delete = jobs.map do |job|
      {
        id: job.id
      }
    end

    @solr.delete_by_id jobs_solr_delete
    @solr.commit
  end
end
