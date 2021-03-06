class Users::MyPagesController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
  end

  def applied_jobs
    @applied_jobs = current_user.jobs.includes(:cities).decorate
  end
end
