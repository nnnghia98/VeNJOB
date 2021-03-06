# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  activated              :boolean
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  cv_path                :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)
#  last_name              :string(255)
#  remember_created_at    :datetime
#  remember_digest        :string(255)
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  role                   :integer
#  username               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ApplicationRecord
  has_many :user_jobs
  has_many :jobs, through: :user_jobs

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.list_emails
    @emails ||= all.pluck(:email)
  end
end
