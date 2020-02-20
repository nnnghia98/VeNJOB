module JobHelper
  def view_search_result
    params[:city_id] ? "City: #{@jobs[0]["city"]}" :
                       (params[:industry_id] ? "Industry: #{@jobs[0]["industry"]}" : params[:search])
  end
end
