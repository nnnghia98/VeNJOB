require "nokogiri"
require "open-uri"
require "resolv-replace"

class CrawlData
  def initialize

  end

  def crawl_web
    page = Nokogiri::HTML.parse(open(Settings.crawl.base_url))
    total_job = page.css("div.ais-stats h1.col-sm-10 span").text.gsub(",", "").to_f
    total_page = (total_job / 50).floor
    fixed_total_page = 20

    (1..fixed_total_page).each do |each_page|
      page = Nokogiri::HTML.parse(open(URI.encode("https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-#{each_page}-vi.html")))
      (0..49).each do |j|
        job_url = page.css("span.jobtitle h3 a @href")[j].text

        job_page = Nokogiri::HTML.parse(open(URI.encode(job_url)))
        # Job code
        job_code = job_url.split("/").last.split(".")[-2]

        next if job_page.css("div.LeftJobCB").nil?

        # Job title
        job_title = job_page.css("div.top-job-info h1").text.strip

        crawl_job_title_logger = ActiveSupport::Logger.new("log/crawl_data.log")
        crawl_job_title_logger.info "#{job_title}"

        # Job post date
        job_post_date = job_page.css("div.datepost span").text

        job_salary, job_position, job_expiration_date, job_industries, job_level = ""
        job_workplace = []
        detail_job_new = job_page.css("ul.DetailJobNew li p")

        (0..detail_job_new.count - 1).each do |detail_part|
          detail = detail_job_new[detail_part].text
          if detail.include?("Nơi làm việc")
            job_workplace = detail.gsub("/[\r\n]+/", "").partition(":").last.split(",")
          elsif detail.include?("Lương")
            job_salary = detail.gsub("/[\r\n]+/", "").partition(":").last.strip
          elsif detail.include?("Cấp bậc")
            job_level = detail.gsub("/[\r\n]+/", "").partition(":").last.strip
          elsif detail.include?("Hết hạn nộp")
            job_expiration_date = detail.gsub("/[\r\n]+/", "").partition(":").last.strip
          elsif detail.include?("Ngành nghề")
            job_industries = detail.gsub("/[\r\n]+/", "").partition(":").last.split(",")
          end
        end

        job_description, job_requirement = ""
        job_container_detail = job_page.css("div.MarBot20")

        (0..job_container_detail.count - 1).each do |detail_part|
          detail = job_container_detail[detail_part].text
          if detail.include?("Mô tả Công việc")
            job_description = detail.partition("Mô tả Công việc").last
          elsif detail.include?("Yêu Cầu Công Việc")
            job_requirement = detail.partition("Yêu Cầu Công Việc").last
          end
        end

        company_name, company_email, company_address, company_desc, company_code = ""
        # Company full name
        unless job_page.css("div.tit_company").nil?
          company_name = job_page.css("div.tit_company").text.strip
        end
        # Company code
        company_code = job_url.split("/").last.split("-").last.split(".")[-2].strip

        # Company address
        unless job_page.css("p.TitleDetailNew label")[0].nil?
          company_address = job_page.css("p.TitleDetailNew label")[0].text.strip
        end
        # Company description
        company_desc = job_page.css("span#emp_more p").text.strip

        job_workplace.each do |city_name|
          city_id = city_id(city_name)
          company_id = company_id(company_code, company_name, company_address, company_desc)
          job_id = job_id(job_code, job_title, job_salary,
                          job_description, job_requirement,
                          job_level, job_post_date,
                          job_expiration_date, company_id)
          CityJob.find_or_create_by!(job_id: job_id, city_id: city_id)

          job_industries.each do |job_industry|
            industry_id = industry_id(job_industry.strip)
            IndustryJob.find_or_create_by!(industry_id: industry_id, job_id: job_id)
          end
        end
      end
    end
  end

  def company_id(code, name, address, description)
    company = Company.find_or_initialize_by(code: code)
    company.update(name: name, address: address, description: description)
    company.id
  end

  def industry_id(name)
    industry = Industry.find_or_create_by!(name: name)
    industry.id
  end

  def city_id(name)
    name = name.strip
    City.find_or_create_by(name: name, region: "Việt Nam").id
  end

  def job_id(code = nil, title, salary, description, requirement, level, post_date, expiration_date, company_id)
    if expiration_date.nil?
      job = Job.find_or_initialize_by(title: job_title, company_id: company_id)
    else
      job = Job.find_or_initialize_by(code: code)
    end

    job.update(code: code,
               title: title,
               salary: salary,
               post_date: post_date,
               description: description,
               requirement: requirement,
               expiration_date: expiration_date,
               level: level,
               company_id: company_id)
    job.id
  end
end
