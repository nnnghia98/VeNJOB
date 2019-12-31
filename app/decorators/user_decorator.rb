class UserDecorator < ApplicationDecorator
  include ActionView::Helpers::TextHelper

  delegate_all
  decorates_association :jobs

  def apply_available
    object.jobs.find_by(job_id: jobs.id)
  end
end
