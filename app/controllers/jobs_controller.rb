class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def import
    Job.jobs_import
    redirect_to jobs_index_path
  end
end
