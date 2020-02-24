class Users::AdminsController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :validate_user, only: :index

  def index
    redirect_to root_path unless current_user.role?
    params[:search_user] ||= ""
    get_applied_jobs(params[:search_user])
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :first_name, :last_name, :role)
  end

  def get_applied_jobs(email)
    @applied_jobs = []
    if email != ""
      users = User.find_by(email: email)
      @applied_jobs = users.jobs
    elsif email = "" || nil
      all_applied_jobs = UserJob.where.not(applied_at: nil).to_a

      (0..all_applied_jobs.count - 1).each do |each_job|
        @applied_jobs << (all_applied_jobs[each_job].job)
      end
    end
  end

  def validate_user
    if params[:search_user] != ""
      redirect_to users_admin_path unless User.find_by(email: params[:search_user])
    end
  end
end
