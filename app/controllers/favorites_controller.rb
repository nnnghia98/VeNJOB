class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:favorite, :unfavorite]

  def favorite
    redirect_to jobs_path if params[:job_id].blank?
    job_id = params[:job_id]

    get_user_job = get_user_job

    if get_user_job
      @favorite_jobs = get_user_job.update(favorited_at: Time.current)
    else
      @favorite_jobs = UserJob.create!(user_id: current_user.id, job_id: job_id, favorited_at: Time.current)
    end

    @favorite_job = UserJob.find_or_initialize_by(user_id: current_user.id, job_id: job_id)
    unless @favorite_job.save!
      render json: {}
    end

    redirect_to job_path(job_id)
  end

  def unfavorite
    redirect_to jobs_path if params[:job_id].blank?
    job_id = params[:job_id]

    @favorited_jobs = get_user_job.update(favorited_at: nil)

    redirect_to job_path(job_id)
  end

  private

  def get_user_job
    UserJob.find_by(user_id: current_user.id, job_id: params[:job_id])
  end
end
