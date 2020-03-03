class Users::AdminsController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    redirect_to root_path unless current_user.role?
    params[:search_user] ||= ""
    @applied_jobs = get_applied_jobs(params[:search_user])
    @user = User.find_by(email: params[:search_user])
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :first_name, :last_name, :role)
  end

  def get_applied_jobs(email)
    applied_jobs = []
    if email != ""
      user = User.find_by(email: email)
      return redirect_to users_admin_path, notice: "User/job not found!" if user.blank?

      applied_jobs = user.jobs
    elsif email = "" || nil
      all_applied_jobs = UserJob.where.not(applied_at: nil).to_a

      (0..all_applied_jobs.count - 1).each do |each_job|
        applied_jobs << (all_applied_jobs[each_job].job)
      end

      applied_jobs
    end
  end
end
