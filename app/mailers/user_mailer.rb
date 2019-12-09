class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers

  default :from => ENV["EMAIL_ADDRESS"]
end
