# == Schema Information
#
# Table name: companies
#
#  id          :bigint           not null, primary key
#  address     :string(255)
#  code        :string(255)
#  description :text(65535)
#  email       :string(255)
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_companies_on_code   (code) UNIQUE
#  index_companies_on_email  (email) UNIQUE
#

class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
end
