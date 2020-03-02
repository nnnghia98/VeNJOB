class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_favorited_job, only: [:create, :destroy]

  def create
    redirect_to new_user_session_path unless user_signed_in?
    redirect_to jobs_path if @job.id.blank?

    job_id = @job.id
    @all_favorite_job.find_by(job_id: job_id) ||
    @all_favorite_job.create!(user_id: current_user.id, job_id: job_id, favorited_at: Time.current)

    redirect_to job_path(job_id)
  end

  def destroy
    redirect_to new_user_session_path unless user_signed_in?
    redirect_to jobs_path if @job.id.blank?

    job_id = @job.id
    @all_favorite_job.find_by(job_id: job_id).destroy

    redirect_to job_path(job_id)
  end

  private

  def find_favorited_job
    @all_favorite_job = current_user.user_jobs.where.not(favorited_at: nil)
  end
end
