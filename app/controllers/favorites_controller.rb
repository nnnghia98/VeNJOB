class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    redirect_to jobs_path if params[:id].blank?
    job_id = params[:id]

    if get_user_job
      @favorite_jobs = get_user_job.where.not(favorited_at: nil) ||
                       get_user_job.update(favorited_at: Time.current)
    else
      @favorite_jobs = UserJob.create!(user_id: current_user.id, job_id: job_id, favorited_at: Time.current)
    end
  end

  def destroy
    redirect_to jobs_path if @job.id.blank?
    job_id = params[:id]

    @favorited_jobs = get_user_job.where.not(favorited_at: nil)
    @favorited_jobs = get_user_job.update(favorited_at: nil)

    redirect_to job_path(job_id)
  end

  private

  def get_user_job
    UserJob.find_by(user_id: current_user.id, job_id: params[:id])
  end
end
