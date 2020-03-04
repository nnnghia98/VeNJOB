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

      user.jobs
    else
      UserJob.where.not(applied_at: nil).collect { |uj| uj.job }
    end
  end
end
