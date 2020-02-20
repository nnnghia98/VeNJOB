class JobDecorator < ApplicationDecorator
  include ActionView::Helpers::TextHelper

  delegate_all
  decorates_association :city
  decorates_association :user

  def city_name
    object.cities&.first&.name
  end

  def company_name
    object.company&.name
  end

  def display_short_des
    simple_format object.requirement&.truncate(250)
  end

  def display_description
    simple_format object.description
  end

  def apply_available(user)
    object.users.find_by(id: user.id)
  end
end
