class JobDecorator < Draper::Decorator
  delegate_all
  decorates_association :city

  def city_name
    object&.cities&.first&.name
  end

  def display_short_des
    object.short_des.truncate(250)
  end
end
