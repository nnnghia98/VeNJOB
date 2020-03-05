module JobHelper
  def view_search_result
    params[:city_id] ? "City: #{@jobs[0]["city"]}" :
                       (params[:industry_id] ? "Industry: #{@jobs[0]["industry"]}" : params[:search])
  end

  def job_applied_at(job)
    job.user_jobs.find_by(user_id: current_user.id).applied_at
  end
end
