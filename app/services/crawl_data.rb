require "nokogiri"
require "open-uri"
require "resolv-replace"
require "openssl"
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
class CrawlData
  def crawl_web
    page = Nokogiri::HTML.parse(open(Settings.crawl.base_url, ssl_verify_mode: nil))
    total_job = page.css("div.ais-stats h1.col-sm-10 span").text.gsub(",", "").to_f
    return if total_job == 0
    total_page = (total_job / Settings.crawl.jobs_per_page).floor
    crawl_job_title_logger = ActiveSupport::Logger.new("log/crawl_data.log")
    crawl_job_title_logger.info "Crawl at #{Time.current}"

    (1..Settings.crawl.fixed_total_page).each do |each_page|
      page = Nokogiri::HTML.parse(open(URI.encode("https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-#{each_page}-vi.html")))
      (0..49).each do |j|
        job_url = page.css(".jobtitle h3 a @href")[j].text

        job_page = Nokogiri::HTML.parse(open(URI.encode(job_url)))

        job = JobHtml.new(job_page).parse_job

        next if job_page.css(".LeftJobCB").nil? || job[:workplace].blank?

        # Job code
        job_code = job_url.split("/").last.split(".")[-2] || ""

        # Company code
        company_code = job_page.css(".viewmorejob a @href").present? ?
                       job_page.css(".viewmorejob a @href").text.split("/").last.split("-")[-2].strip : ""

        crawl_job_title_logger.info "#{job[:title]}"

        job[:workplace].each do |city_name|
          city_id = get_city(city_name).id
          company_id = get_company(company_code, job[:company_name], job[:company_address], job[:company_description]).id
          job_id = get_job(job_code, job[:title], job[:salary],
                          job[:description], job[:requirement],
                          job[:level], job[:post_date],
                          job[:expiration_date], company_id).id
          CityJob.find_or_create_by!(job_id: job_id, city_id: city_id)

          job[:industries].each do |job_industry|
            job_industry = job_industry.strip
            industry_id = get_industry(job_industry).id
            IndustryJob.find_or_create_by!(industry_id: industry_id, job_id: job_id)
          end
        end
      end
    end
  end

  def get_company(code, name, address, description)
    company = Company.find_or_initialize_by(code: code)
    company.update(name: name, address: address, description: description)
    company
  end

  def get_industry(name)
    industry = Industry.find_or_create_by!(name: name)
    industry
  end

  def get_city(name)
    name = name.strip
    City.find_or_create_by(name: name, region: "Việt Nam")
  end

  def get_job(code = nil, title, salary, description, requirement, level, post_date, expiration_date, company_id)
    attrs = expiration_date.nil? ? {title: job_title, company_id: company_id} : {code: code}
    job = Job.find_or_initialize_by attrs

    job.update(code: code,
               title: title,
               salary: salary,
               post_date: post_date,
               description: description,
               requirement: requirement,
               expiration_date: expiration_date,
               level: level,
               company_id: company_id)
    job
  end
end
