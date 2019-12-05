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
    @company ||= Company.find_or_create_by(code: @row["company id"])
  end

  def csv_attributes
    {title: self.title, level: self.level, salary: self.salary, description: self.description,
     short_des: self.short_des, requirement: self.requirement, category: self.category,
     company_id: self.company_id}
  end
end
