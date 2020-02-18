module JobHelper
  def view_jobs_count(count)
    params[:city_id] ? count : (params[:industry_id] ? count : count)
  end

  def view_search_result
    params[:city_id] ? "City: #{@jobs[0]["city"]}" :
                       (params[:industry_id] ? "Industry: #{@jobs[0]["industry"]}" : params[:search])
  end
end
