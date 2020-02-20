class JobCrawl
  def initialize(attr)
    @attr = attr
  end

  def title
    @title ||= job_title
  end

  def level
    @level ||= job_level
  end

  def salary
    @salary ||= job_salary
  end

  def description
    @description ||= job_description
  end

  def post_date
    @post_date ||= job_post_date
  end

  def requirement
    @requirement ||= job_requirement
  end

  def expiration_date
    @job_expiration_date ||= job_expiration_date
  end

  def code
    @code ||= job_code
  end

  def company_id
    @company_id ||= company.id
  end

  def company
    @company ||= Company.find_by(code: company_code) ||
                 Company.create(name: company_name, address: company_address,
                                email: company_mail, code: company_code, description: company_desc)
  end

  def crawl_attributes
    {code: job_code,
     name: job_name,
     salary: job_salary,
     post_date: job_post_date,
     description: job_description,
     requirement: job_requirement,
     expiration_date: job_expiration_date,
     level: job_level,
     company_id: company_id}
  end
end
