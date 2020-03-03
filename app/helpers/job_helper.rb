module JobHelper
  def view_search_result
    params[:city_id] ? "City: #{@jobs[0]["city"]}" :
                       (params[:industry_id] ? "Industry: #{@jobs[0]["industry"]}" : params[:search])
  end

  def job_applied_at(job_id)
    UserJob.where.not(applied_at: nil).find_by(job_id: job_id).applied_at
  end
end
