module JobHelper
  def view_jobs_count(count)
    params[:city_id] ? count : (params[:industry_id] ? count : count)
  end

  def view_search_result
    params[:city_id] ? "City: #{@city.name}" :
                       (params[:industry_id] ? "Industry: #{@industry.name}" : params[:search])
  end
end
