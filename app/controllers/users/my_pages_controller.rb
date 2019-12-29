class Users::MyPagesController < ApplicationController
  def show
  end

  def applied_jobs
    @applied_jobs = current_user.jobs.all
  end
end
