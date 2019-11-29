class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def import
    Job.jobs_import
  end
end
