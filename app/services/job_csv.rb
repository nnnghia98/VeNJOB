class JobCsv
  def initialize(row)
    @row = row
  end

  def title
    @title ||= @row["name"]
  end

  def level
    @level ||= @row["level"]
  end

  def salary
    @salary ||= @row["salary"]
  end

  def description
    @description ||= @row["description"]
  end

  def short_des
    @short_des ||= @row["benefit"]
  end

  def requirement
    @requirement ||= @row["requirement"]
  end

  def category
    @category ||= @row["type"]
  end

  def company_id
    @company_id ||= company.id
  end

  def company
    @company ||= Company.find_by(code: @row["company id"]) ||
                 Company.create(name: @row["company name"], email: @row["contact email"],
                                                            address: @row["company address"],
                                                            code: @row["company id"])
  end

  def csv_attributes
    {title: title, level: level, salary: salary, description: description,
     short_des: short_des, requirement: requirement, category: category,
     company_id: company_id}
  end
end
