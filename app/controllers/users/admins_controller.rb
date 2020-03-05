class Users::AdminsController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    redirect_to root_path unless current_user.role?
    params[:search_user]
    @applied_jobs = get_applied_jobs

    @user = User.find_by(email: params[:search_user])
  end

  private

  def get_applied_jobs
    if params[:search_user]
      user = User.find_by(email: params[:search_user])
      return redirect_to users_admin_path, notice: "User/job not found!" if user.blank?

      applied_jobs = user.jobs
      applied_jobs.page(params[:page]).per(Settings.job.per_page)
    else
      Job.joins(:user_jobs).where.not(user_jobs: { applied_at: nil}).distinct
    end
  end
end
