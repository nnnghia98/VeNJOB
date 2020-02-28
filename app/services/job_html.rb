class JobHtml
  def initialize( html_data = {} )
    @html_data = html_data
  end

  def parse_job
    get_job_info
    get_job_detail
    job = { title: get_title,
            salary: @job_salary,
            level: @job_level,
            post_date: get_post_date,
            description: @job_description,
            requirement: @job_requirement,
            expiration_date: @job_expiration_date,
            workplace: @job_workplace,
            level: @job_level,
            industries: @job_industries,
            company_name: get_company_name,
            company_address: get_company_address,
            company_description: get_company_description }
    return job
  end

  def get_title
    @job_title = @html_data.css(".top-job-info h1").text.strip
  end

  def get_post_date
    @job_post_date = @html_data.css(".datepost span").text
  end

  def get_job_info
    info_container = @html_data.css(".DetailJobNew li p")

    job_info = (0..info_container.count - 1).map do |info_part|
      info = info_container[info_part].text
      case
      when info.include?("Nơi làm việc")
        @job_workplace = info.gsub("/[\r\n]+/", "").partition(":").last.split(",")
      when info.include?("Lương")
        @job_salary = info.gsub("/[\r\n]+/", "").partition(":").last.strip
      when info.include?("Cấp bậc")
        @job_level = info.gsub("/[\r\n]+/", "").partition(":").last.strip
      when info.include?("Hết hạn nộp")
        @job_expiration_date = info.gsub("/[\r\n]+/", "").partition(":").last.strip
      when info.include?("Ngành nghề")
        @job_industries = info.gsub("/[\r\n]+/", "").partition(":").last.split(",")
      end
    end
  end

  def get_job_detail
    detail_container = @html_data.css("div.MarBot20")

    job_detail = (0..detail_container.count - 1).map do |detail_part|
      detail = detail_container[detail_part].text
      if detail.include?("Mô tả Công việc")
        @job_description = detail.partition("Mô tả Công việc").last
      elsif detail.include?("Yêu Cầu Công Việc")
        @job_requirement = detail.partition("Yêu Cầu Công Việc").last
      end
    end
  end

  def get_company_name
    @html_data.css(".tit_company").present? ? @html_data.css("div.tit_company").text.strip : ""
  end

  def get_company_description
    @html_data.css("#emp_more p").text.strip
  end

  def get_company_address
    @html_data.css(".TitleDetailNew label")[0].present? ? @html_data.css("p.TitleDetailNew label")[0].text.strip : ""
  end
end
