class Users::MyPagesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :applied_jobs]

  def show
  end

  def applied_jobs
    @applied_jobs = current_user.jobs.all.decorate
  end
end
