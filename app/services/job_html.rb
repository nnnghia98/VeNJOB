class JobHtml
  def initialize( html_data = {} )
    @html_data = html_data
  end

  def parse_job
    get_job_info
    get_job_detail
    { title: get_title,
      salary: get_job_info[:salary],
      level: get_job_info[:level],
      post_date: get_post_date,
      description: get_job_detail[:description],
      requirement: get_job_detail[:requirement],
      expiration_date: get_job_info[:expiration_date],
      workplace: get_job_info[:workplace],
      industries: get_job_info[:industries],
      company_name: get_company_name,
      company_address: get_company_address,
      company_description: get_company_description }
  end

  private

  def get_title
    @html_data.css(".top-job-info h1").text.strip
  end

  def get_post_date
    @html_data.css(".datepost span").text
  end

  def get_job_info
    info_container = @html_data.css(".DetailJobNew li p")
    job_info = {}

    (0..info_container.count - 1).each do |info_part|
      info = info_container[info_part].text
      case
      when info.include?("Nơi làm việc")
        job_info[:workplace] = info.gsub("/[\r\n]+/", "").partition(":").last.split(",") || []
      when info.include?("Lương")
        job_info[:salary] = info.gsub("/[\r\n]+/", "").partition(":").last.strip
      when info.include?("Cấp bậc")
        job_info[:level] = info.gsub("/[\r\n]+/", "").partition(":").last.strip
      when info.include?("Hết hạn nộp")
        job_info[:expiration_date] = info.gsub("/[\r\n]+/", "").partition(":").last.strip
      when info.include?("Ngành nghề")
        job_info[:industries] = info.gsub("/[\r\n]+/", "").partition(":").last.split(",")
      end
    end

    return job_info
  end

  def get_job_detail
    detail_container = @html_data.css("div.MarBot20")
    job_detail = {}

    (0..detail_container.count - 1).map do |detail_part|
      detail = detail_container[detail_part].text
      if detail.include?("Mô tả Công việc")
        job_detail[:description] = detail.partition("Mô tả Công việc").last
      elsif detail.include?("Yêu Cầu Công Việc")
        job_detail[:requirement] = detail.partition("Yêu Cầu Công Việc").last
      end
    end

    return job_detail
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
